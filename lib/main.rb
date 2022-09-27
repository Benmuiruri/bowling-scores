require_relative './helpers/read_file'

class Main
  include FileReader

  def main
    file = get_file
    play_game(file)
  end

  def get_file
    puts 'Please enter the name of your bowling scores file:'
    file = gets.chomp
  end

  def play_game(file)
    FileReader.file_exists?(file)
    players = FileReader.get_players(file)
    frames = FileReader.get_frames(file)
  end
end