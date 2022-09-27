module FileReader
  def self.file_exists?(file)
    if File.file?(file)
      puts 'File with bowling scores exists, reading file to validate score format...'
      sleep 0.5
      validate_score_format(file)
    else
      puts 'File not found. Please check your file path.'
      exit
    end
  end

  def self.validate_score_format(file)
    puts 'Validating score format...'
    sleep 0.5
    File.read(file).each_line do |line|
      if line.match(/(\w+)\t(\w+)/)
        validate_score(line)
      else
        puts "#{line} is an invalid score format, please check your file and try again."
        exit
      end
    end
  end

  def self.validate_score(line)
    scores = line.chomp.split("\t")
    unless scores[1].match(/^([0-9]|10)$|F/)
      puts "#{scores[1]} is an invalid score. Please check the scores in the file."
      exit
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
