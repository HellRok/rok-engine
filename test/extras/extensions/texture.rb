class TestEngineTexture < MTest::Unit::TestCase
  def test_load
    texture = Texture2D.load('test/assets/test.png')
    assert_equal 10, texture.width
    assert_equal 10, texture.height
    assert_equal 1, texture.mipmaps
    assert_equal 4, texture.format
  end

  def test_draw_no_args
    texture = Texture2D.load('test/assets/test.png')

    clear_background WHITE
    texture.draw
    flush_frame

    assert_equal fixture_draw_no_args, get_screen_data.data
  end

  def test_draw_rotate
    texture = Texture2D.load('test/assets/test.png')

    clear_background WHITE
    texture.draw(origin: Vector2.new(5, 5), rotation: 90)
    flush_frame

    assert_equal fixture_draw_no_args, get_screen_data.data
  end
end
