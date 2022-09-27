module GameFixtures
  def play(bowls)
    bowls.each { |bowl| @game.play bowl }
  end
end
