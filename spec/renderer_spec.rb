require 'renderer'

RSpec.describe Renderer do
  subject(:renderer) { Renderer.new }
  
  let(:pixels) do
    [
      [ false,  false,  true,   false,  false ],
      [ true,   false,  true,   false,  true  ],
      [ false,  true,   false,  true,   false ]
    ]
  end
  
  describe '#render' do
    it 'should turn a 2 dimensional array of boolean values into ascii art' do
      expect(renderer.render(pixels)).to eq("--o--\no-o-o\n-o-o-\n")
    end
  end
end