require_relative 'player'

module Bowling
  class Game
    attr_reader :players, :player_index

    def initialize(names)
      @players = []
      names.each { |name| @players << Player.new(name) }
    end
  end
end