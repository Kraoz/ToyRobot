require 'test/unit'
require_relative '../lib/table.rb'
require_relative '../lib/robot.rb'

class TableTest < Test::Unit::TestCase

  def test_position_within
    assert_true Table.new(5, 5).position_within?(Robot::Position[0, 0])
    assert_true Table.new(5, 5).position_within?(Robot::Position[4, 4])
    assert_false Table.new(5, 5).position_within?(Robot::Position[5, 4])
    assert_false Table.new(5, 5).position_within?(Robot::Position[4, 5])
  end
end
