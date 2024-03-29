require_relative './helpers/read_file'
require_relative 'bowling/game'

# Main class initializes the game by reading data from file and simulating the game and displaying score
class Main
  include FileReader
  include Bowling

  def main
    file = input_file
    play_game(file)
  end

  def input_file
    puts 'Please enter the name of your bowling scores file:'
    gets.chomp
  end

  def play_game(file)
    FileReader.validate_file(file)
    players = FileReader.get_players(file)
    frames = FileReader.get_frames(file)
    bowling = Bowling::Game.new(players)

    frames.each do |frame|
      bowling.play(frame.to_i)
    end

    bowling.scoreboard
  end
end

game = Main.new
game.main
