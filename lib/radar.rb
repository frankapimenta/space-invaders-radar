# Used to discover matrixs, given a radar sample matrix
# and a screen matrix to output the results.

class Radar
  attr_reader :sample, :screen
  
  def initialize(sample, screen)
    @sample = sample
    @screen = screen
  end

  def discover!(matrix)
    ((1 - matrix.height)...(sample.height - 1)).each do |y|
      ((1 - matrix.width)...(sample.width - 1)).each do |x|
        if y < 0
          top = 0
          crop_top = -y
          crop_height = matrix.height - crop_top
        elsif (y + matrix.height) > sample.height
          top = y
          crop_top = 0
          crop_height = screen.height - y
        else
          top = y
          crop_top = 0
          crop_height = matrix.height
        end
        
        if x < 0
          left = 0
          crop_left = -x
          crop_width = matrix.width - crop_left
        elsif (x + matrix.width) > sample.width
          left = x
          crop_left = 0
          crop_width = screen.width - x
        else
          left = x
          crop_left = 0
          crop_width = matrix.width
        end
        
        subject = if crop_top > 0 || crop_left > 0 || crop_height < matrix.height || crop_width < matrix.width
          matrix.crop(crop_left, crop_top, crop_width, crop_height)
        else
          matrix
        end      
        
        if sample.crop(left, top, crop_width, crop_height).visible?(subject)
          screen.overlay!(left, top, subject)
        end
      end
    end
  end
end