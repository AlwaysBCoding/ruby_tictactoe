require 'computer'
require 'game'
require 'colorize'

describe 'Computer' do

	describe "#minimax" do

		xit 'knows how to win with two moves' do
			game = Game.new("C", "H")
			game.make_move(:player2, game.square1)
			game.make_move(:player1, game.square2)
			game.make_move(:player2, game.square3)
			game.make_move(:player1, game.square4)
			game.make_move(:player1, game.square5)
			game.make_move(:player2, game.square6)
			#game.make_move(:player2, game.square7)
			game.make_move(:player2, game.square8)
			#game.make_move(:player1, game.square9)
			game.board.draw()
			game.player1.minimax(game, :player1, :player1).should eq(game.square9)
			# -1, 0
		end

		it 'knows how to win with three moves' do
			game = Game.new("C", "H")
			game.make_move(:player2, game.square1)
			game.make_move(:player1, game.square2)
			game.make_move(:player2, game.square3)
			game.make_move(:player1, game.square4)
			game.make_move(:player1, game.square5)
			game.make_move(:player2, game.square6)
			#game.make_move(:player2, game.square7)
			#game.make_move(:player2, game.square8)
			#game.make_move(:player1, game.square9)
			game.board.draw()
			game.player1.minimax(game, :player1, :player1).should eq(game.square8)
		end

	end

end
