require 'test/unit'
require_relative '../lib/robot.rb'
require_relative '../lib/table.rb'

class RobotTest < Test::Unit::TestCase

  def new_robot
    Robot.new Table.new(3, 3)
  end

  def new_placed_robot x, y, f
    robot = new_robot
    robot.execute! 'place', x, y, f
    robot
  end

  def assert_robot robot, x, y, f
    assert_equal robot.position.x, x
    assert_equal robot.position.y, y
    assert_equal robot.orientation, f
  end

  def test_raise_when_invalid_command_is_given
    assert_raise Robot::UnavailableCommand do
      new_robot.execute! 'should_fail'
    end
  end

  def test_place
    robot = new_robot
    assert_nil robot.position
    robot.execute! 'place', 1, 2, 'NORTH'
    assert_robot robot, 1, 2, :NORTH
  end

  def test_move
    robot = new_placed_robot 0, 1, 'NORTH'
    robot.execute! 'move'
    assert_robot robot, 0, 2, :NORTH
  end

  def test_left
    robot = new_placed_robot 0, 1, 'NORTH'
    robot.execute! 'left'
    assert_robot robot, 0, 1, :WEST
    robot.execute! 'left'
    assert_robot robot, 0, 1, :SOUTH
    robot.execute! 'left'
    assert_robot robot, 0, 1, :EAST
    robot.execute! 'left'
    assert_robot robot, 0, 1, :NORTH
  end

  def test_right
    robot = new_placed_robot 0, 1, 'NORTH'
    robot.execute! 'right'
    assert_robot robot, 0, 1, :EAST
    robot.execute! 'right'
    assert_robot robot, 0, 1, :SOUTH
    robot.execute! 'right'
    assert_robot robot, 0, 1, :WEST
    robot.execute! 'right'
    assert_robot robot, 0, 1, :NORTH
  end

  def assert_output output
    stdout = $stdout.dup
    $stdout = StringIO.new
    yield
    assert_equal $stdout.string, output
  ensure
    $stdout = stdout
  end

  def test_report
    assert_output "0,1,NORTH\n" do
      new_placed_robot(0, 1, 'NORTH').execute! 'report'
    end
    assert_output "1,2,NORTH\n" do
      new_placed_robot(1, 2, 'NORTH').execute! 'report'
    end
  end

  %w{move left right report}.each do |command|
    define_method "test_#{command}_ignored_when_not_placed" do
      robot = new_robot
      assert_nil robot.position
      assert_nil robot.orientation
      robot.execute! command
      assert_nil robot.position
      assert_nil robot.orientation
    end
  end
end
