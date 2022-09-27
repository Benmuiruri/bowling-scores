require 'spec_helper'
require 'main'
require 'pry'

RSpec.describe Main do
  let(:perfect) { FileFixtures.file_fixture('perfect.txt') }

  context 'when the file exists' do
    context 'with valid score format' do
      it 'expect file content to be valid' do
        expect(FileReader.file_exists?(perfect)).to match(/(\w+)\t(\w+)/)
      end
    end
    context 'when validating score' do
      it 'expect score to be valid' do
        scores = FileReader.file_exists?(perfect).chomp.split("\t")
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
