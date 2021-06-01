require 'spec_helper.rb'
require 'main.rb'

RSpec.describe Main do
  context 'when input file is valid' do
    context 'and the game has more than two players' do
      xit 'prints the game scoreboard to stdout' do
      end
    end

    context 'and all frames are strikes' do
      xit 'prints a perfect game scoreboard' do
      end
    end

    context 'and all frames are fouls' do
      xit 'prints the game scoreboard to stdout' do
      end
    end
  end

  context 'when input file is invalid' do
    context 'with invalid characters present' do
      xit 'raises the corresponding error message'
    end

    context 'with invalid score' do
      xit 'raises the corresponding error message'
    end

    context 'with invalid number of throwings' do
      xit 'raises the corresponding error message'
    end
  end
end
