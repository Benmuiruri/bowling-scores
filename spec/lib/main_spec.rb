require 'spec_helper'
require 'main'
require 'pry'

RSpec.describe Main do
  let(:perfect) { FileFixtures.file_fixture('perfect.txt') }
  let(:empty) { FileFixtures.file_fixture('empty.txt') }
  let(:invalid_score) { FileFixtures.file_fixture('invalid-score.txt') }
  let(:negative) { FileFixtures.file_fixture('negative.txt') }
  let(:invalid_format) { FileFixtures.file_fixture('free-text.txt') }

  context 'when the file exists' do
    context 'when the file has correct data' do
      context 'with valid score format' do
        it 'expect file score format to be valid' do
          expect(FileReader.validate_file(perfect)).to match(/(\w+)\t(\w+)/)
        end
      end

      context 'when validating score' do
        it 'expect score to be valid' do
          scores = FileReader.validate_file(perfect).chomp.split("\t")
          expect(scores[1]).to match(/^([0-9]|10)$|F/)
        end
      end

      context 'when getting players' do
        it 'expect players to be unique' do
          players = FileReader.get_players(perfect)
          expect(players.uniq).to eq(players)
        end
      end

      context 'when getting frames' do
        it 'expect frames to be an array' do
          expect(FileReader.get_frames(perfect)).to be_an(Array)
        end
      end
    end

    context 'when the file has incorrect data' do
      context 'when the file is empty' do
        it 'expect file to be empty' do
          expect(File.zero?(empty)).to be true
        end
      end

      context 'with incorrect score format' do
        it 'expect file score format to be invalid' do
          expect(FileReader.validate_file(invalid_format)).not_to match(/(\w+)\t(\w+)/)
        end
      end

      context 'with invalid score value' do
        it 'expect score to be invalid' do
          scores = FileReader.validate_file(invalid_score).chomp.split("\t")
          expect(scores[1]).not_to match(/^([0-9]|10)$|F/)
        end
      end
    end
  end

  context 'when the file does not exist' do
    it 'expect file to not exist' do
      expect(FileReader.validate_file('not_a_file.txt')).to eq('File not found. Please check your file path.')
    end
  end

  context 'when input file is valid' do
    context 'with more than two players' do
      xit 'prints the game scoreboard to stdout' do
      end
    end

    context 'with strikes in all throwings' do
      xit 'prints a perfect game scoreboard' do
      end
    end

    context 'with fouls in all throwings' do
      xit 'prints the game scoreboard to stdout' do
      end
    end
  end

  context 'when input file is invalid' do
    context 'with invalid characters present' do
      xit 'raises the corresponding error message' do
      end
    end

    context 'with invalid score' do
      xit 'raises the corresponding error message' do
      end
    end

    context 'with invalid number of throwings' do
      xit 'raises the corresponding error message' do
      end
    end
  end
end
