require 'test/unit'
require_relative '../lib/command.rb'

class CommandTest < Test::Unit::TestCase

  def test_new_without_arguments
    command = Command.new 'test argument1, argument2'
    assert_equal command.name, 'test'
    assert_equal command.arguments, ['argument1', 'argument2']
  end

  def test_new_with_arguments
    command = Command.new 'test2'
    assert_equal command.name, 'test2'
  end

  def test_new_with_invalid_command
    assert_raise Command::Invalid do
      Command.new ''
    end
  end

  def with_stdin_gets input
    stdin = $stdin
    $stdin = Struct.new(:gets).new input
    yield
  ensure
    $stdin = stdin
  end

  def test_next!
    with_stdin_gets "test2 arg1\n" do
      command = Command.next!
      assert_equal command.name, 'test2'
      assert_equal command.arguments, ['arg1']
    end
    with_stdin_gets nil do
      assert_nil Command.next!
    end
  end
end
