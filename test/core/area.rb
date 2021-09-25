class TestEngineArea < MTest::Unit::TestCase
  def test_add_listener
    area1 = Area.new(0, 0, 10, 10)
    area2 = Area.new(0, 0, 10, 10)

    assert_equal 0, area1.listeners.size

    area1.add_listener(area2, event: 'test')
    assert_equal 1, area1.listeners.size
    assert_equal area2,  area1.listeners.first[:listener]
    assert_equal 'test', area1.listeners.first[:event]
    assert_equal 0,      area1.listeners.first[:debounce]
    assert_equal 0,      area1.listeners.first[:last_collided_at]
  end

  def test_collision_exact_match
    scene = TestScene.new
    manager = SceneManager.new(scene)

    test_node = TestNode.new
    scene.add_child(test_node)

    area1 = Area.new(0, 0, 10, 10)
    test_node.add_child(area1)

    area2 = Area.new(0, 0, 10, 10)
    test_node.add_child(area2)

    area1.add_listener(area2, event: 'test')

    test_node.add_listener('test') { test_node.update(0) }

    assert_nil test_node.updated
    area1.update(0)
    assert_true test_node.updated
  end

  def test_collision_overlap
    scene = TestScene.new
    manager = SceneManager.new(scene)

    test_node = TestNode.new
    scene.add_child(test_node)

    area1 = Area.new(0, 0, 10, 10)
    test_node.add_child(area1)

    area2 = Area.new(5, 5, 10, 10)
    test_node.add_child(area2)

    area1.add_listener(area2, event: 'test')

    test_node.add_listener('test') { test_node.update(0) }

    assert_nil test_node.updated
    area1.update(0)
    assert_true test_node.updated
  end

  def test_collision_inside
    scene = TestScene.new
    manager = SceneManager.new(scene)

    test_node = TestNode.new
    scene.add_child(test_node)

    area1 = Area.new(0, 0, 10, 10)
    test_node.add_child(area1)

    area2 = Area.new(5, 5, 2, 2)
    test_node.add_child(area2)

    area1.add_listener(area2, event: 'test')

    test_node.add_listener('test') { test_node.update(0) }

    assert_nil test_node.updated
    area1.update(0)
    assert_true test_node.updated
  end

  def test_collision_enclosed
    scene = TestScene.new
    manager = SceneManager.new(scene)

    test_node = TestNode.new
    scene.add_child(test_node)

    area1 = Area.new(0, 0, 10, 10)
    test_node.add_child(area1)

    area2 = Area.new(-2, -2, 12, 12)
    test_node.add_child(area2)

    area1.add_listener(area2, event: 'test')

    test_node.add_listener('test') { test_node.update(0) }

    assert_nil test_node.updated
    area1.update(0)
    assert_true test_node.updated
  end

  def test_collision_outside
    scene = TestScene.new
    manager = SceneManager.new(scene)

    test_node = TestNode.new
    scene.add_child(test_node)

    area1 = Area.new(0, 0, 10, 10)
    test_node.add_child(area1)

    area2 = Area.new(15, 15, 2, 2)
    test_node.add_child(area2)

    area1.add_listener(area2, event: 'test')

    test_node.add_listener('test') { test_node.update(0) }

    assert_nil test_node.updated
    area1.update(0)
    assert_nil test_node.updated
  end

  def test_collision_side_touching
    scene = TestScene.new
    manager = SceneManager.new(scene)

    test_node = TestNode.new
    scene.add_child(test_node)

    area1 = Area.new(0, 0, 10, 10)
    test_node.add_child(area1)

    area2 = Area.new(10, 10, 2, 2)
    test_node.add_child(area2)

    area1.add_listener(area2, event: 'test')

    test_node.add_listener('test') { test_node.update(0) }

    assert_nil test_node.updated
    area1.update(0)
    assert_nil test_node.updated
  end

  def test_collision_debounce
    scene = TestScene.new
    manager = SceneManager.new(scene)

    test_node = TestNode.new
    scene.add_child(test_node)

    area1 = Area.new(0, 0, 10, 10)
    test_node.add_child(area1)

    area2 = Area.new(0, 0, 10, 10)
    test_node.add_child(area2)

    area1.add_listener(area2, event: 'test', debounce: 0.5)

    test_node.add_listener('test') { test_node.update(0) }

    assert_nil test_node.updated
    # It always runs on the first frame
    area1.update(0)
    assert_true test_node.updated

    test_node.updated = false
    area1.update(0.4)
    assert_false test_node.updated
    area1.update(0.1)
    assert_true test_node.updated
  end
end
