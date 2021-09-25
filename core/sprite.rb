class Sprite < Node
  attr_accessor :x, :y, :rotation, :colour, :rotation, :origin, :hidden
  def initialize(x, y, texture)
    @position = Vector2.new(x, y)
    @texture = load_texture(texture)

    @rotation = 0
    @source = Rectangle.new(0, 0, @texture.width, @texture.height)
    @destination = Rectangle.new(@position.x, @position.y, @texture.width, @texture.height)
    @origin = Vector2.new(@texture.width / 2, @texture.height / 2)
    @colour = WHITE
    @hidden = false
  end

  def show?
    !@hidden
  end

  def width
    @texture.width
  end

  def height
    @texture.height
  end

  def add_child_callback
    update(0)
  end

  def render
    if show?
      draw_texture_pro(
        @texture,
        @source,
        @destination,
        @origin,
        @rotation,
        @colour
      )
    end
  end

  def update(delta)
    @destination.x = parent.position.x + @position.x
    @destination.y = parent.position.y + @position.y
  end

  def teardown
    unload_texture(@texture)
  end

  def flip
    if @source.x.zero?
      @source.x = @source.width
      @source.width *= -1
    else
      @source.width *= -1
      @source.x = @source.width
    end
  end
end
