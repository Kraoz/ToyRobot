class Command

  MATCH_REGEXP = /^(\w+)\s*(.*)$/

  class Invalid < Exception
    def initialize raw_command
      super "Command #{raw_command} doesn't match #{MATCH_REGEXP}"
    end
  end

  attr_accessor :name, :arguments

  def self.next!
    raw_command = gets
    raw_command && self.new(raw_command)
  end

  def initialize raw_command
    match = raw_command.chomp.match MATCH_REGEXP
    raise Invalid.new raw_command if match.nil?
    self.arguments = match[2] ? match[2].split(',') : []
    self.name = match[1].downcase
  end
end
