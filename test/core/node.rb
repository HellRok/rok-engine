class TestEngineNode < MTest::Unit::TestCase
  def test_children
    assert_equal [], TestNode.new.children
  end

  def test_add_child
    node = TestNode.new
    child = TestNode.new
    node.add_child(child)

    assert_equal [child], node.children
  end

  def test_add_child_callback
    node = TestNode.new
    child = TestNode.new

    assert_false child.child_callback_run
    node.add_child(child)
    assert_true child.child_callback_run
  end

  def test_remove_child
    node = TestNode.new
    child = TestNode.new
    node.add_child(child)

    assert_equal [child], node.children
    assert_nil child.torndown

    node.remove_child(child)
    assert_equal [], node.children
    assert_true child.torndown
  end

  def test_remove_self
    node = TestNode.new
    child = TestNode.new
    node.add_child(child)

    assert_equal [child], node.children
    assert_nil child.torndown

    child.remove_self
    assert_equal [], node.children
    assert_true child.torndown
  end

  def test_paused
    node = TestNode.new
    assert_false node.paused
  end

  def test_pause
    node = TestNode.new
    assert_false node.paused

    node.pause
    assert_true node.paused
  end

  def test_unpause
    node = TestNode.new
    assert_false node.paused

    node.pause
    assert_true node.paused

    node.unpause
    assert_false node.paused
  end

  def test_update
    node = TestNode.new
    child = TestNode.new
    node.add_child(child)

    assert_nil node.updated
    assert_nil child.updated

    node.tick(1)
    assert_true node.updated
    assert_true child.updated
  end

  def test_update_paused
    node = TestNode.new
    child = TestNode.new
    node.add_child(child)
    child.pause

    assert_nil node.updated
    assert_nil child.updated

    node.tick(1)
    assert_true node.updated
    assert_false child.updated
  end
end
