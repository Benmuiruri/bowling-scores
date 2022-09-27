require 'spec_helper'
require_relative '../../lib/bowling/game'

RSpec.describe 'Bowling::Game' do
  let(:perfect) { FileFixtures.file_fixture('perfect.txt') }
  let(:multiplayer) { FileFixtures.file_fixture('scores.txt') }

  before do
    players = FileReader.get_players(perfect)
    @game = Bowling::Game.new(players)
    @player = @game.players.first
    @bowls = FileReader.get_frames(perfect).map(&:to_i)
  end

  context 'when the player completes the game' do
    it 'prints the to stdout' do
      expect { @game.print_player(@player) }.to output.to_stdout
    end
  end

  context 'with fouls in all throwings' do
    it 'prints a score of 0 to stdout' do
      @bowls = [0, 0]
      10.times { play @bowls }
      expect(@player.score).to be 0
    end
  end

  context 'with player getting a strike' do
    before do
      @bowls = [10, 10, 4, 2]
      play @bowls
      @frame = @player.frames.first
    end

    it 'records a strike when 10 pins fall in one bowl' do
      expect(@frame.strike?).to be true
    end
  end

  context 'with a player getting a spare' do
    before do
      @bowls = [4, 6, 5, 4]
      play @bowls
      @frame = @player.frames.first
    end

    it 'records a spare when 10 pins fall in two bowls' do
      expect(@frame.spare?).to be true
    end
  end

  context 'when player reaches the 10th frame' do
    context 'when in the final bonus frame' do
      it 'has a maximum of three bowls if all strikes' do
        12.times { play [10] }
        expect(@player.frames.last.bowls.size).to be 3
      end

      it 'has 3 bowls if a spare is scored' do
        9.times { play [10] }
        play [5, 5, 4]
        expect(@player.frames.last.bowls.size).to be 3
      end

      it 'does not offer extra bowls without a bonus bowl' do
        9.times { play [0, 0] }
        play [5, 4]
        expect(@player.frames.last.extra_bowls).to be 0
      end
    end
  end

  context 'when multiple players play the game' do
    before do
      @players = FileReader.get_players(multiplayer)
      @game = Bowling::Game.new(@players)
    end

    context 'when game has two players' do
      it 'has two players' do
        expect(@game.players.size).to be 2
      end
    end

    context 'when two players are playing' do
      it 'switches between the players' do
        second_player_name = @players[1]
        play [2, 1]
        expect(@game.current_player.name).to eql second_player_name
      end

      it "keeps track of first player's scores" do
        first_player = @game.players.first
        play [3, 5]
        expect(first_player.score).to be 8
      end

      it "keeps track of second player's scores" do
        second_player = @game.players.last
        play [0, 0]
        expect(second_player.score).to be 0
      end
    end
  end
end
