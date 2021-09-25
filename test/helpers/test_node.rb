class TestNode < Node
  attr_accessor :position, :updated, :child_callback_run, :torndown

  def initialize
    @position = Vector2.new(0, 0)
  end

  def update(_delta)
    @updated = true
  end

  def add_child_callback
    @child_callback_run = true
  end

  def teardown
    @torndown = true
  end
end
