class Texture2D
  def self.load(path)
    load_texture(path)
  end

  def draw(destination: nil, source: nil, origin: nil, rotation: 0, colour: WHITE)
    @_draw_destination_default ||= Rectangle.new(0, 0, self.width, self.height)
    @_draw_source_default ||= Rectangle.new(0, 0, self.width, self.height)
    @_draw_origin_default ||= Vector2.new(0, 0)

    puts [
      self,
      source || @_draw_source_default,
      destination || @_draw_destination_default,
      origin || @_draw_origin_default,
      rotation,
      colour
    ]

    draw_texture_pro(
      self,
      source || @_draw_source_default,
      destination || @_draw_destination_default,
      origin || @_draw_origin_default,
      rotation,
      colour
    )
  end
end
