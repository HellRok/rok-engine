class TestEngineSceneManager < MTest::Unit::TestCase
  def test_initialize
    scene = TestScene.new
    manager = SceneManager.new(scene)
    assert_kind_of Events, manager.events
    assert_equal scene, manager.current_scene
    assert_true scene.setup_ran
    assert_false scene.teardown_ran
  end

  def test_switch_to
    scene1 = TestScene.new
    scene2 = TestScene.new
    manager = SceneManager.new(scene1)

    assert_true scene1.setup_ran
    assert_false scene1.teardown_ran
    assert_false scene2.setup_ran
    assert_false scene2.teardown_ran

    manager.switch_to(scene2)
    assert_equal scene2, manager.current_scene
    assert_true scene1.setup_ran
    assert_true scene1.teardown_ran
    assert_true scene2.setup_ran
    assert_false scene2.teardown_ran
  end

  def test_update
    scene = TestScene.new
    manager = SceneManager.new(scene)

    assert_false scene.ticked
    manager.update(1)
    assert_true scene.ticked
  end

  def test_events
    scene = TestScene.new
    manager = SceneManager.new(scene)

    node = TestNode.new
    scene.add_child(node)

    event_fired = false
    node.add_listener('event') { event_fired = true }

    assert_equal false, event_fired
    assert_false event_fired

    scene.trigger('event')

    assert_equal true, event_fired
  end
end
