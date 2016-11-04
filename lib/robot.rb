class Robot

  class UnavailableCommand < Exception
    def initialize command_name
      super "unavailable command named '#{command_name}'"
    end
  end

  Position = Struct.new(:x, :y)

  attr_accessor :table
  attr_reader :position, :orientation

  def initialize table
    self.table = table
  end

  def execute! command_name, *command_arguments
    self.available_command! command_name
    self.send command_name, *command_arguments
  end

protected
  def place x, y, orientation
    self.position = Position[x.to_i, y.to_i]
    self.orientation = orientation
  end

  def move
    return unless self.placed?
    self.position = case self.orientation
      when :NORTH then Position[self.position.x, self.position.y + 1]
      when :EAST then Position[self.position.x + 1, self.position.y]
      when :SOUTH then Position[self.position.x, self.position.y - 1]
      when :WEST then Position[self.position.x - 1, self.position.y]
    end
  end

  def left
    return unless self.placed?
    self.orientation = self.class.orientations[self.orientation_index - 1]
  end

  def right
    return unless self.placed?
    self.orientation = self.class.orientations[self.orientation_index + 1] ||
      self.class.orientations.first
  end

  def report
    return unless self.placed?
    puts "#{self.position.x},#{self.position.y},#{self.orientation}"
  end

  def self.available_commands
    @@available_commands ||= [
      'place',
      'move',
      'left',
      'right',
      'report',
    ]
  end

  def self.orientations
    @@orientations ||= [
      'NORTH',
      'EAST',
      'SOUTH',
      'WEST',
    ]
  end

  def available_command? command_name
    self.class.available_commands.include? command_name
  end

  def available_command! command_name
    unless self.available_command? command_name
      raise UnavailableCommand.new command_name
    end
  end

  def placed?
    !self.position.nil? && !self.orientation.nil?
  end

  def position_inside_table? position
    position.x >= 0 && position.x < self.table.width &&
      position.y >= 0 && position.y < self.table.height
  end

  def valid_orientation? orientation
    self.class.orientations.include? orientation
  end

  def position= position
    @position = position if self.position_inside_table? position
  end

  def orientation= orientation
    @orientation = orientation.to_sym if self.valid_orientation? orientation
  end

  def orientation_index
    self.class.orientations.index self.orientation.to_s
  end
end
