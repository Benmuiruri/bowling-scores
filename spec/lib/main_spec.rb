require 'spec_helper'
require_relative '../../lib/bowling/game'

RSpec.describe 'Main' do
  let(:perfect) { FileFixtures.file_fixture('perfect.txt') }
  let(:empty) { FileFixtures.file_fixture('empty.txt') }
  let(:invalid_score) { FileFixtures.file_fixture('invalid-score.txt') }
  let(:negative) { FileFixtures.file_fixture('negative.txt') }
  let(:invalid_format) { FileFixtures.file_fixture('free-text.txt') }
  let(:mising_file) { FileReader.validate_file('not_a_file.txt') }

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
        it 'raises an argument error' do
          expect { FileReader.validate_file(invalid_format) }.to raise_error(ArgumentError)
        end
      end

      context 'with invalid score value' do
        it 'raises an argument error ' do
          expect { FileReader.validate_file(invalid_score) }
            .to raise_error(ArgumentError)
        end
      end
    end

    context 'when the file does not exist' do
      it "Raises 'File not found' error" do
        expect { FileReader.validate_file(mising_file) }
          .to raise_error(ArgumentError)
      end
    end
  end
end
