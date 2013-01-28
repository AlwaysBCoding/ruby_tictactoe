require 'computer'
require 'game'
require 'colorize'

describe 'Computer' do

	describe "#minimax" do

		context "#get_minimax_squares" do

			it 'returns an array of correct scores' do
				game = Game.new("C", "H")
				game.make_move(:player2, game.square1)
				game.make_move(:player1, game.square2)
				game.make_move(:player2, game.square3)
				game.make_move(:player1, game.square4)
				game.make_move(:player1, game.square5)
				game.make_move(:player2, game.square6)

				game.player1.minimax(game, :player1, :player1).should eq game.square8
			end

			it 'knows how to win with two moves' do
				game = Game.new("C", "H")
				game.make_move(:player2, game.square1)
				game.make_move(:player1, game.square2)
				game.make_move(:player2, game.square3)
				game.make_move(:player1, game.square4)
				game.make_move(:player1, game.square5)
				game.make_move(:player2, game.square6)
				# game.make_move(:player2, game.square7)
				game.make_move(:player2, game.square8)
				# game.make_move(:player1, game.square9)
				game.player1.minimax(game, :player1, :player1).should eq(game.square9)
			end

			it 'knows how to win with three moves' do
				game = Game.new("C", "H")
				game.make_move(:player2, game.square1)
				game.make_move(:player1, game.square2)
				game.make_move(:player2, game.square3)
				game.make_move(:player1, game.square4)
				game.make_move(:player1, game.square5)
				game.make_move(:player2, game.square6)
				# game.make_move(:player2, game.square7)
				# game.make_move(:player2, game.square8)
				# game.make_move(:player1, game.square9)
				game.player1.minimax(game, :player1, :player1).should eq(game.square8)
			end

			it 'knows how to win with four moves' do
				game = Game.new("C", "H")
				game.make_move(:player2, game.square1)
				game.make_move(:player1, game.square2)
				game.make_move(:player2, game.square3)
				# game.make_move(:player1, game.square4)
				game.make_move(:player1, game.square5)
				game.make_move(:player2, game.square6)
				# game.make_move(:player2, game.square7)
				# game.make_move(:player2, game.square8)
				# game.make_move(:player1, game.square9)
				game.player1.minimax(game, :player1, :player1).should eq(game.square8)
			end

			it 'knows how to win with five moves' do
				game = Game.new("C", "H")
				game.make_move(:player2, game.square1)
				game.make_move(:player1, game.square2)
				game.make_move(:player2, game.square3)
				# game.make_move(:player1, game.square4)
				game.make_move(:player1, game.square5)
				# game.make_move(:player2, game.square6)
				# game.make_move(:player2, game.square7)
				# game.make_move(:player2, game.square8)
				# game.make_move(:player1, game.square9)
				game.player1.minimax(game, :player1, :player1).should eq(game.square4)
			end

			it 'knows how to take the middle when the human starts with a corner' do
				game = Game.new("H", "C")
				game.make_move(:player1, game.square1)
				# game.make_move(:player1, game.square2)
				# game.make_move(:player2, game.square3)
				# game.make_move(:player1, game.square4)
				# game.make_move(:player1, game.square5)
				# game.make_move(:player2, game.square6)
				# game.make_move(:player2, game.square7)
			  # game.make_move(:player2, game.square8)
				# game.make_move(:player1, game.square9)
				game.player2.minimax(game, :player2, :player2).should eq(game.square5)
			end

		end

	end

end
