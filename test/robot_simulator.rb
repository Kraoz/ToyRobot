require 'test/unit'
require_relative '../lib/robot_simulator.rb'

class RobotSimulatorTest < Test::Unit::TestCase

  class RobotDuck
    def self.execute! name, *args
      $result.push [name, args]
    end
  end

  class CommandDuck
    def self.next!
      @@commands_index ||= -1
      @@commands_index += 1
      $commands[@@commands_index]
    end
  end

  def test_run
    $result = []
    command = Struct.new :name, :arguments
    $commands = [
      command['test1', ['arg1']],
      command['test2', ['arg1', 'arg2']],
    ]
    RobotSimulator.run! RobotDuck, CommandDuck
    assert_equal $result, [
      ['test1', ['arg1']],
      ['test2', ['arg1', 'arg2']],
    ]
  end
end
