class TestScene
  include Scene

  attr_accessor :ticked, :setup_ran, :teardown_ran

  def update(delta)
    @ticked = true
  end

  def setup
    @setup_ran = true
  end

  def teardown
    @teardown_ran = true
  end
end
