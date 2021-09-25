class TestEngineDelay < MTest::Unit::TestCase
  def test_initialize
    delay = Delay.new(event: 'test', length: 0.5)

    assert_equal 'test', delay.event
    assert_equal 0.5, delay.length
    assert_equal 0, delay.timer
  end

  def test_timer_update
    delay = Delay.new(event: 'test', length: 0.5)

    assert_equal 0, delay.timer
    delay.update(0.25)
    assert_equal 0.25, delay.timer
  end

  def test_trigger
    event_fired = false
    scene = TestScene.new
    manager = SceneManager.new(scene)
    scene.add_listener('test') { event_fired = true }

    delay = Delay.new(event: 'test', length: 0.5)
    scene.add_child(delay)

    assert_false event_fired
    manager.update(1)
    assert_true event_fired
  end

  def test_block
    event_fired = false
    scene = TestScene.new
    manager = SceneManager.new(scene)

    delay = Delay.new(length: 0.5) { event_fired = true }
    scene.add_child(delay)

    assert_false event_fired
    manager.update(1)
    assert_true event_fired
  end
end
