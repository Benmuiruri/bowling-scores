module Bowling
  # BonusFrame class handles the final bonus frame
  class BonusFrame < Frame
    def bowl(pins)
      remaining = remaining_pins - pins
      if (remaining.negative? && extra_bowls.zero?) || pins > MAX_PINS
        raise ArgumentError,
              'Invalid number of pins'
      end

      @remaining_pins = remaining unless bonus?
      bowls << pins
    end

    def bonus?
      bowls.take(2).reduce(:+) == MAX_PINS || strike?
    end

    def extra_bowls
      if strike?
        2
      elsif spare?
        1
      else
        0
      end
    end

    def complete?
      (bowls.size == 2 && !bonus?) || (bonus? && bowls.size == 3)
    end

    def to_s
      remaining_bowls = bowls.dup
      bowl_string = ''
      frame = Frame.new
      until remaining_bowls.empty?
        frame.bowl(remaining_bowls.shift)
        bowl_string << frame.to_s if frame.complete?
        frame = Frame.new
      end
      bowl_string << frame.to_s unless frame.complete?
      bowl_string
    end
  end
end
