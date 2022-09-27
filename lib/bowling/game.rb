require 'colorize'
require_relative 'player'
require_relative 'frame/frame'
require_relative 'frame/bonus_frame'

module Bowling
  class Game
    attr_reader :players, :player_index

    def initialize(names)
      @players = []
      names.each { |name| @players << Player.new(name) }
      reset_player
    end

    def switch_player
      if player_index < players.size - 1
        @player_index += 1
      else
        reset_player
      end
    end

    def next_player
      switch_player if current_player.frames.last.complete?
    end

    def reset_player
      @player_index = 0
    end

    def current_player
      players[player_index]
    end

    def play(pins)
      scoreboard if game_over?
      current_player.bowl(pins)
      next_player
    end

    def print_player(player)
      puts "\n #{player.name}"
      board = player.scoreboard
      puts board
    end

    def scoreboard
      puts "\n These are the scores for the game".colorize(:light_green)
      frames = players.first.frames.count
      frame_count = "\n Frame".ljust(12)
      frames.times do |i|
        frame_count << (i + 1).to_s.ljust(10)
      end
      puts frame_count
      players.each { |player| print_player(player) }
      puts "\n Thank you for playing 👍\n".colorize(:green)
      sleep 0.5
      puts 'Goodbye, See you next Time 😀'.colorize(:magenta)
      exit
    end

    def game_over?
      players.last.complete_playing?
    end
  end
end
