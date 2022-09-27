# frozen_string_literal: true
require 'colorize'

module Bowling
  class Player
    MAX_FRAMES = 10

    attr_reader :name, :frames

    def initialize(name)
      @name = name
      @frames = []
      new_frame
    end

    def bowl(pins)
      new_frame if current_frame.complete?
      current_frame.bowl(pins)
    end

    def last_two_bowls(frame_no)
      next_two_frames = frames[(frame_no + 1)..(frame_no + 2)]
      next_bowls = next_two_frames.inject([]) { |bowls, frame| bowls += frame.bowls if frame.complete? } || []
      next_bowls.take(2)
    end

    def score
      initial_frames_score + bonus_frame_score
    end

    def bonus_frame_score
      bonus_frame_total = 0
      last_frame = frames.last
      bonus_frame_total += last_frame.score if frames.size == MAX_FRAMES && last_frame.complete?
      bonus_frame_total
    end

    def initial_frames_score
      frame_no = 0
      total_score = 0
      while frame_no < MAX_FRAMES - 1 && frame_no < frames.size
        frame = frames[frame_no]
        break unless frame.complete?

        total_score += total_frame_score(frame, frame_no)
        frame_no += 1
      end
      total_score
    end

    def total_frame_score(frame, frame_no)
      total_score = frame.score
      total_score += bonus_scorekeeper(frame, frame_no) if frame.bonus?
      total_score
    end

    def bonus_scorekeeper(frame, frame_no)
      total = 0
      two_bowls = last_two_bowls(frame_no)
      if frame.strike? && two_bowls.size == 2
        total += two_bowls.reduce(:+)
      elsif frame.spare? && !two_bowls.first.nil?
        total += two_bowls.first
      end
      total
    end

    def scoreboard
      output = 'Pinfalls'.ljust(10)
      frames.each do |frame|
        output << frame.to_s.ljust(10)
      end
      output << '|'.ljust(6) << "Score = #{score.to_s}".colorize(:light_green)
    end

    def complete_playing?
      frames.size == MAX_FRAMES && frames.last.complete? || frames.size > MAX_FRAMES
    end

    private

    attr_reader :current_frame
    attr_writer :frames

    def new_frame
      frames << if frames.size == MAX_FRAMES - 1
                  BonusFrame.new
                else
                  Frame.new
                end
      @current_frame = frames.last
    end
  end
end
