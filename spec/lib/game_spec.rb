require 'spec_helper'
require_relative '../../lib/bowling/game'

RSpec.describe 'Bowling::Game' do
  let(:perfect) { FileFixtures.file_fixture('perfect.txt') }
  let(:multiplayer) { FileFixtures.file_fixture('scores.txt') }
  before do
    @players = FileReader.get_players(perfect)
    @game = Bowling::Game.new(@players)
    @player = @game.players.first
    @bowls = FileReader.get_frames(perfect).map(&:to_i)
  end

  context 'when one player plays the game' do
    context 'when the player completes the game' do
      it 'prints the to stdout' do
        expect { @game.print_player(@player) }.to output.to_stdout
      end
    end

    context 'with fouls in all throwings' do
      it 'prints a score of 0 to stdout' do
        @bowls = [0, 0]
        10.times { play @bowls }
        expect(@player.score).to eql 0
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

      it 'adds a bonus to the score when player bowls a strike' do
        expect(@player.score).to eql 46
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

      it 'adds a bonus to the score when player bowls a spare' do
        expect(@player.score).to eql 24
      end
    end

    context 'when player reaches the 10th frame' do
      context 'final bonus frame' do
        it 'should have a maximum of three bowls if all strikes' do
          12.times { play [10] }
          expect(@player.frames.last.bowls.size).to eql 3
          expect(@player.frames.last.extra_bowls).to eql 2
        end

        it 'should have 3 bowls if a spare is scored' do
          9.times { play [10] }
          play [5, 5, 4]
          expect(@player.frames.last.bowls.size).to eql 3
          expect(@player.frames.last.extra_bowls).to eql 1
        end

        it 'should not offer extra bowls without a bonus bowl' do
          9.times { play [0, 0] }
          play [5, 4]
          expect(@game.game_over?).to be true
          expect(@player.frames.last.extra_bowls).to eql 0
        end
      end
    end
  end

  context 'when multiple players play the game' do
    before do
      @players = FileReader.get_players(multiplayer)
      @game = Bowling::Game.new(@players)
    end
    context 'when game has two players' do
      it 'should have two players' do
        expect(@game.players.size).to eql 2
      end
    end

    context 'when two players are playing' do
      it 'should switch between the players' do
        player_1_name = @players[0]
        player_2_name = @players[1]
        expect(@game.current_player.name).to eql player_1_name
        play [2, 1]
        expect(@game.current_player.name).to eql player_2_name
      end

      it "should keep track of different player's scores" do
        player_1 = @game.players.first
        player_2 = @game.players.last

        play [3, 5]
        expect(player_1.score).to be 8

        play [8, 1]
        expect(player_2.score).to be 9
      end
    end
  end
end
