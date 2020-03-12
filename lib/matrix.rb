# Represents a 2 dimensional array of boolean values, and
# allows comparison between them.

class Matrix  
  attr_reader :pixels
  
  def initialize(pixels)
    @pixels = pixels
  end
  
  def width
    pixels.first.size
  end
  
  def height
    pixels.size
  end
  
  def crop(x, y, width, height)
    bottom = y + height
    right = x + width
    
    unless x >= 0 && y >= 0 && bottom <= self.height && right <= self.width
      raise ArgumentError, 'Can only crop within matrix boundaries.'
    end
    
    self.class.new(pixels[y...bottom].map { |row| row[x...right] })
  end
  
  def overlay!(x, y, matrix)
    unless x >= 0 && y >= 0 && x + matrix.width <= width && y + matrix.height <= height
      raise ArgumentError, 'Can only overlay within matrix boundaries.'
    end
    
    matrix.pixels.each_with_index do |row, y_index|
      row.each_with_index do |value, x_index|
        pixels[y_index + y][x_index + x] = true if value
      end
    end
  end

  def visible?(matrix, tolerance: 0.8)
    unless matrix.width == width && matrix.height == height
      raise ArgumentError, 'Can only compare a matrix of the same dimensions.'
    end
    
    positives = 0
    overlaps = 0
    
    pixels.each_with_index do |row, y|
      row.each_with_index do |value, x|
        next unless matrix.pixels[y][x]
        positives += 1
        overlaps += 1 if value
      end
    end
    
    overlaps > (tolerance * positives)
  end
  
  # Class Methods
  
  def self.blank(width, height)
    new(Array.new(height) { Array.new(width, false) })
  end
end