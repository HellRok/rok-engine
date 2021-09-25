class TestEngineFadeOut < MTest::Unit::TestCase
  def test_initialize
    fade = FadeOut.new(0.5) { }

    assert_equal 0.5, fade.duration
    assert_equal 0, fade.timer
  end

  def test_timer_update
    scene = TestScene.new
    manager = SceneManager.new(scene)
    fade = FadeOut.new(0.5) { }
    scene.add_child(fade)

    assert_equal 0, fade.timer
    assert_equal 0, fade.opacity

    fade.update(0.25)
    assert_equal 0.25, fade.timer
    assert_equal 127.5, fade.opacity

    fade.update(0.25)
    assert_equal 0.5, fade.timer
    assert_equal 255, fade.opacity
  end
end
