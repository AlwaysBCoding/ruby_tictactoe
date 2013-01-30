require 'human' ; require 'board' ; require 'game'

describe 'Human' do
	describe "#make_moves" do

		it 'changes the value of multiple squares' do
			game = Game.new("H", "C")
			game.player1.make_moves(game.square1, game.square2, game.square3)
			game.player1_win?.should be_true
		end

	end
end
