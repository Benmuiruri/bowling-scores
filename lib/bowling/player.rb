module Bowling
  class Player
    MAX_FRAMES = 10

    attr_reader :name, :frames

    def initialize(name)
      @name = name
      @frames = []
      new_frame
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