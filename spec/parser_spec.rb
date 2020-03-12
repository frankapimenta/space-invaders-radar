require 'parser'

RSpec.describe Parser do
  subject(:parser) { Parser.new }
  
  let(:ascii) do
    ascii = <<~SAMPLE
      --o--
      o-o-o
      -o-o-
    SAMPLE
  end
  
  describe '#parse' do
    it 'should turn ascii art into a 2 dimensional array of boolean values' do
      expect(parser.parse(ascii)).to eq([
        [ false,  false,  true,   false,  false ],
        [ true,   false,  true,   false,  true  ],
        [ false,  true,   false,  true,   false ]
      ])
    end
  end
end