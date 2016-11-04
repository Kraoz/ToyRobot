module RobotSimulator

  def self.run! robot, commands
    while command = commands.next!
      robot.execute! command.name, command.arguments
    end
  end
end
