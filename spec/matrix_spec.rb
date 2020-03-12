require 'matrix'

RSpec.describe Matrix do
  subject(:matrix) do
    Matrix.new([
      [ false,  false,  true,   false,  false ],
      [ true,   false,  true,   false,  true  ],
      [ false,  true,   false,  true,   false ]
    ])
  end
  
  describe '#width' do
    it 'should return the correct width in pixels' do
      expect(matrix.width).to eq(5)
    end
  end
  
  describe '#height' do
    it 'should return the correct height in pixels' do
      expect(matrix.height).to eq(3)
    end
  end
  
  describe '#crop' do
    it 'should return a cropped area as a new Matrix' do      
      expect(matrix.crop(2, 1, 2, 2).pixels).to eq([
        [ true,   false ],
        [ false,  true  ]
      ])
    end
    
    it 'should raise error for invalid boundaries' do      
      expect { matrix.crop(-1, 0, 2, 2) }.to raise_error(ArgumentError)
      expect { matrix.crop(0, -1, 2, 2) }.to raise_error(ArgumentError)
      expect { matrix.crop(4, 0, 2, 2) }.to raise_error(ArgumentError)
      expect { matrix.crop(0, 2, 2, 2) }.to raise_error(ArgumentError)
      expect { matrix.crop(0, 0, 6, 3) }.to raise_error(ArgumentError)
      expect { matrix.crop(0, 0, 5, 4) }.to raise_error(ArgumentError)
    end
  end
  
  describe '#overlay!' do
    let(:overlay) do
      Matrix.new([
        [ true,   false,  false ],
        [ true,   true,   true  ]
      ])
    end
    
    it 'should overlay the supplied Matrix on in-place' do
      matrix.overlay!(2, 1, overlay)
           
      expect(matrix.pixels).to eq([
        [ false,  false,  true,   false,  false ],
        [ true,   false,  true,   false,  true  ],
        [ false,  true,   true,   true,   true  ]
      ])
    end
    
    it 'should raise error for invalid boundaries' do      
      expect { matrix.overlay!(-1, 0, overlay) }.to raise_error(ArgumentError)
      expect { matrix.overlay!(0, -1, overlay) }.to raise_error(ArgumentError)
      expect { matrix.overlay!(3, 0, overlay) }.to raise_error(ArgumentError)
      expect { matrix.overlay!(0, 2, overlay) }.to raise_error(ArgumentError)
    end
  end
  
  describe '#visible?' do
    it 'should return true if more that 80% match' do
      comparison = Matrix.new([
        [ false,  false,  true,   false,  false ],
        [ true,   false,  false,  false,  true  ],
        [ false,  true,   false,  true,   true  ]
      ])
               
      expect(matrix.visible?(comparison)).to eq(true)
    end
    
    it 'should return false if less that 80% match' do
      comparison = Matrix.new([
        [ false,  true,   false,  false,  false ],
        [ true,   false,  false,  false,  true  ],
        [ false,  true,   false,  true,   false ]
      ])
               
      expect(matrix.visible?(comparison)).to eq(false)
    end
    
    it 'should raise error when matrixes are different in size' do
      comparison = Matrix.new([
        [ false,  true,   false,  false,  false ],
        [ true,   false,  false,  false,  true  ]
      ])
       
      expect { matrix.visible?(comparison) }.to raise_error(ArgumentError)
    end
  end
  
  describe '.blank' do
    it 'should return a blank matrix with supplied dimensions' do
      expect(Matrix.blank(4, 2).pixels).to eq([
        [ false,  false,  false,  false ],
        [ false,  false,  false,  false ]
      ])
    end 
  end
end