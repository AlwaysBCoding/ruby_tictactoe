require 'game' ; require 'board' ; require 'computer' ; require 'human' ; require 'square'

describe 'Computer' do
	
	let(:game) { Game.new("C") }

	describe "#minimax" do

		context 'a winning board returns 1' do
		
			it 'for all "O"' do
				game.squares.each do |sq|
					game.computer.make_move(sq)
				end
				game.computer_win?.should be_true
			end
		
		end

		it 'a losing board returns -1' do

		end

		it 'a draw returns 0' do

		end

		xit 'returns the center on the first move' do
			game.human.make_move(game.square1)
			answer = game.computer.minimax(game.board)
			answer.should == game.square5		
		end

	end

end
