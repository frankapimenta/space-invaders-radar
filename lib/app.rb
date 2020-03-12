require_relative 'matrix'
require_relative 'parser'
require_relative 'radar'
require_relative 'renderer'

module App
  ASCII_INVADER_1 = <<~INVADER
    --o-----o--
    ---o---o---
    --ooooooo--
    -oo-ooo-oo-
    ooooooooooo
    o-ooooooo-o
    o-o-----o-o
    ---oo-oo---
  INVADER
  
  ASCII_INVADER_2 = <<~INVADER
    ---oo---
    --oooo--
    -oooooo-
    oo-oo-oo
    oooooooo
    --o--o--
    -o-oo-o-
    o-o--o-o
  INVADER
  
  ASCII_INVADERS = [ASCII_INVADER_1, ASCII_INVADER_2]

  def self.run(ascii_sample)
    parser = Parser.new
    renderer = Renderer.new
    sample = Matrix.new(parser.parse(ascii_sample))
    screen = Matrix.blank(sample.width, sample.height)
    radar = Radar.new(sample, screen)
    
    ASCII_INVADERS.each do |ascii_invader|
      radar.discover!(Matrix.new(parser.parse(ascii_invader)))
    end
    
    renderer.render(radar.screen.pixels)
  end
end