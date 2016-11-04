class Table

  attr_accessor :width, :height

  def initialize width, height
    self.width = width
    self.height = height
  end

  def position_within? position
    position.x >= 0 && position.x < self.width &&
      position.y >= 0 && position.y < self.height
  end
end
