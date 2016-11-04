class Robot

  class UnavailableCommand < Exception
    def initialize command_name
      super "unavailable command named '#{command_name}'"
    end
  end

  Position = Struct.new(:x, :y)

  attr_accessor :table, :position, :orientation

  def self.available_commands
    @@available_commands ||= [
      'place',
      'move',
      'left',
      'right',
      'report',
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

  def initialize table
    self.table = table
  end

  def execute! command_name, command_arguments
    p "EXECUTING [#{command_name}] with [#{command_arguments}]"
    self.available_command! command_name
    self.send command_name, *command_arguments
  end

  def place x, y, f
    p "PLACE X: #{x}, Y: #{y}, F: #{f}"
  end

  def move
  end

  def left
  end

  def right
  end

  def report
  end
end
