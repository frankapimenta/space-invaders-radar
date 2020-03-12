# Takes an ASCII matrix and converts it into 2 dimensional
# array of boolean values.

class Parser
  NEWLINE = "\n"
  POSITIVE = 'o'
  NEGATIVE = '-'
  
  def parse(ascii)
    ascii.strip.split(NEWLINE).map do |line|
      line.each_char.map { |char| char == POSITIVE }
    end
  end
end