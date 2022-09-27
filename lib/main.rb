# frozen_string_literal: true

require_relative './helpers/read_file'
require_relative 'bowling/game'

class Main
  include FileReader
  include Bowling

  def main
    file = get_file
    play_game(file)
  end

  def get_file
    puts 'Please enter the name of your bowling scores file:'
    file = gets.chomp
  end

  def play_game(file)
    FileReader.validate_file(file)
    players = FileReader.get_players(file)
    frames = FileReader.get_frames(file)
    bowling = Bowling::Game.new(players)

    frames.each do |frame|
      bowling.rolls(frame.to_i)
    end

    bowling.scoreboard
  end
end
