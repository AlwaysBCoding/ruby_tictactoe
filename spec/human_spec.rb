require 'human' ; require 'board' ; require 'game'

describe 'Human' do
	describe "#make_moves" do
		
		it 'changes the value of multiple squares' do
			game = Game.new("C")
			game.human.make_moves(game.square1, game.square2, game.square3)
			game.human_win?.should be_true
		end

	end
end
