# The renderer takes a 2 dimensional array of boolean
# values, and renders them as ascii art — the opposite of
# the Parser class.

class Renderer
  NEWLINE = "\n"
  POSITIVE = 'o'
  NEGATIVE = '-'
  
  def render(pixels)
    pixels.map do |row|
      row.map { |value| value ? POSITIVE : NEGATIVE }.join
    end.join(NEWLINE) + NEWLINE
  end
end