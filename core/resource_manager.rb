class ResourceManager
  def initialize
    @textures = {}
    @sounds = {}
    @fonts = {}
  end

  def texture(path)
    @textures[path] ||= load_texture(path)
  end

  def font(path)
    @fonts[path] ||= load_font(path)
  end

  def sound(path)
    @sounds[path] ||= load_sound(path)
  end
end
