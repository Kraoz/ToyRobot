require_relative '../lib/robot_simulator.rb'
require_relative '../lib/command.rb'
require_relative '../lib/robot.rb'
require_relative '../lib/table.rb'

RobotSimulator.run!(Robot.new(Table.new(5, 5)), Command)
