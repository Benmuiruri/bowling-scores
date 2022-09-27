# frozen_string_literal: true

module Bowling
  class Frame
    MAX_PINS = 10
    STRIKE = 'X'
    SPARE = '/'
    GUTTER = '-'

    attr_accessor :bowls, :remaining_pins

    def initialize
      @bowls = []
      @remaining_pins = MAX_PINS
    end

    def bowl(pins)
      remaining = remaining_pins - pins
      raise ArgumentError, 'Invalid number of pins' if remaining.negative? || pins > MAX_PINS

      @remaining_pins = remaining
      bowls << pins
    end

    def first_bowl
      bowls.first
    end

    def score
      bowls.reduce(:+)
    end

    def bonus?
      score == MAX_PINS
    end

    def strike?
      first_bowl == MAX_PINS
    end

    def spare?
      bonus? && !strike?
    end

    def gutter?
      bowls.size == 2 && score.zero?
    end

    def complete?
      bowls.size == 2 || remaining_pins.zero?
    end

    def to_s
      if strike?
        STRIKE
      elsif spare?
        "#{first_bowl}#{SPARE}"
      else
        bowls.join('|').gsub('0', GUTTER)
      end
    end
  end
end
