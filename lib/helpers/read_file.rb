require 'colorize'

# Module to read, validate data from file and get players and their scores
module FileReader
  def self.validate_file(file)
    if File.file?(file)
      puts 'File with bowling scores exists, reading file to validate score format...'.colorize(:light_blue)
      sleep 0.5
      validate_score_format(file)
    else
      puts 'File not found. Please check your file path.'.colorize(:red)
      raise ArgumentError, 'File not found. Please check your file path'
    end
  end

  def self.validate_score_format(file)
    puts 'Validating score format...'.colorize(:light_green)
    sleep 0.5
    File.read(file).each_line do |line|
      if line.match(/(\w+)\t(\w+)/)
        validate_score(line)
      else
        puts "#{line} is an invalid score format, please check your file and try again.".colorize(:red)
        raise ArgumentError, 'Presence of invalid score format, please check your score format and try again.'
      end
    end
  end

  def self.validate_score(line)
    scores = line.chomp.split("\t")
    unless scores[1].match(/^([0-9]|10)$|F/)
      puts "#{scores[1]} is an invalid score. Please check the scores in the file.".colorize(:red)
      raise ArgumentError, 'Presence of invalid score, please check your scores and try again.'
    end
    scores[1].replace '0' if scores[1] == 'F'
  end

  def self.get_players(file)
    players = []
    File.read(file).each_line do |line|
      temp = line.chomp.split("\t")
      players << temp[0]
    end
    players.uniq
  end

  def self.get_frames(file)
    frames = []
    File.read(file).each_line do |line|
      temp = line.chomp.split("\t")
      frames << temp[1]
    end
    frames
  end
end
