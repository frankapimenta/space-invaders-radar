require 'radar'

RSpec.describe Radar do
  let(:invader) do
    # Ascii equivalent (not using parser due to coupling):
    # 
    #   oooo
    #   o--o
    #   oooo
    #
    Matrix.new([
      [ true,   true,   true,   true  ],
      [ true,   false,  false,  true  ],
      [ true,   true,   true,   true  ]
    ])
  end
  
  subject(:radar) do
    # Ascii equivalent (not using parser due to coupling):
    # 
    #   -ooo------
    #   o--o------
    #   oooo----oo
    #   -o-o---o--
    #   --o----ooo
    #
    sample = Matrix.new([
      [ false,  true,   true,   true,   false,  false,  false,  false,  false,  false ],
      [ true,   false,  false,  true,   false,  false,  false,  false,  false,  false ],
      [ true,   true,   true,   true,   false,  false,  false,  false,  true,   true  ],
      [ false,  true,   false,  true,   false,  false,  false,  true,   false,  false ],
      [ false,  false,  true,   false,  false,  false,  false,  true,   true,   true  ]
    ])
    
    screen = Matrix.blank(10, 5)
    
    Radar.new(sample, screen)
  end
  
  describe '#discover!' do
    it 'should discover a matrix within the sample and plot it to screen' do
      radar.discover!(invader)
      
      # Ascii equivalent (not using parser due to coupling):
      # 
      #   oooo------
      #   o--o------
      #   oooo---ooo
      #   -------o--
      #   -------ooo
      #
      expect(radar.screen.pixels).to eq([
        [ true,   true,   true,   true,   false,  false,  false,  false,  false,  false ],
        [ true,   false,  false,  true,   false,  false,  false,  false,  false,  false ],
        [ true,   true,   true,   true,   false,  false,  false,  true,   true,   true  ],
        [ false,  false,  false,  false,  false,  false,  false,  true,   false,  false ],
        [ false,  false,  false,  false,  false,  false,  false,  true,   true,   true  ]
      ])
    end
  end
end