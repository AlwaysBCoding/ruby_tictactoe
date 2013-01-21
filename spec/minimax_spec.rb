require 'computer'
require 'game'

describe 'Computer' do

	let(:game) { Game.new("H", "C") }

	describe "#minimax" do
		it 'knows how to win' do
			game.make_move(:player2, game.square1)
			game.make_move(:player1, game.square2)
			game.make_move(:player2, game.square3)
			game.make_move(:player2, game.square4)
			game.make_move(:player1, game.square5)
			game.make_move(:player2, game.square6)
			#game.make_move(:player2, game.square7)
			game.make_move(:player2, game.square8)
			#game.make_move(:player1, game.square9)
			game.player2.minimax(game, :player1, :player1)
			game.player2.rmws()
			# -1, -1
		end

	end

end
