require 'computer'
require 'game'

describe 'Computer' do

	let(:game) { Game.new("H", "C") }

	describe "#minimax" do
		it 'knows how to win' do
			game.make_move(:player2, game.square1)
			game.make_move(:player2, game.square5)
			game.player2.minimax(game, :player2).should eq(game.square9)
		end

	end

end
