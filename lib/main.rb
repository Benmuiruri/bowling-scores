class Main
  def display
    persons = []
    ids = []
    File.read('data.txt').each_line do |line|
      temp = line.chomp.split("\t")
      persons << temp[0]
      ids << temp[1]
    end
    # p persons
    # p ids
    p persons.uniq
  end
end

game = Main.new
game.display
