require 'game' ; require 'board' ; require 'computer' ; require 'human' ; require 'square'

describe 'Computer' do
	
	let(:game) { Game.new("C") }

	describe "#minimax" do

		context 'a winning board returns true' do
		
			it 'for all "O"' do
				game.squares.each do |sq|
					game.computer.make_move(sq)
				end
				game.computer_win?.should be_true
			end

			it 'for a horizontal win' do
				game.computer.make_move(game.square1)
				game.computer.make_move(game.square2)
				game.computer.make_move(game.square3)
				game.computer_win?.should be_true
			end

			it 'for a vertical win' do
				game.computer.make_move(game.square1)
				game.computer.make_move(game.square4)
				game.computer.make_move(game.square7)
				game.computer_win?.should be_true
			end

			it 'for a diagonal win' do
				game.computer.make_move(game.square1)
				game.computer.make_move(game.square5)
				game.computer.make_move(game.square9)
				game.computer_win?.should be_true
			end
		
		end

		context 'a losing board returns true' do
			
			it 'for all "X"' do
				game.squares.each do |sq|
					game.human.make_move(sq)
				end
				game.human_win?.should be_true
			end

			it 'for a horizontal win' do
				game.human.make_move(game.square1)
				game.human.make_move(game.square2)
				game.human.make_move(game.square3)
				game.human_win?.should be_true
			end

			it 'for a vertical win' do
				game.human.make_move(game.square1)
				game.human.make_move(game.square4)
				game.human.make_move(game.square7)
				game.human_win?.should be_true
			end

			it 'for a diagonal win' do
				game.human.make_move(game.square1)
				game.human.make_move(game.square5)
				game.human.make_move(game.square9)
				game.human_win?.should be_true
			end

		end

		context 'a draw returns true' do
			
			it 'for a valid draw' do
				game.human.make_move(game.square1)
				game.computer.make_move(game.square2)
				game.human.make_move(game.square3)
				game.computer.make_move(game.square4)			
				game.human.make_move(game.square5)
				game.computer.make_move(game.square6)
				game.computer.make_move(game.square7)
				game.human.make_move(game.square8)
				game.computer.make_move(game.square9)
				game.draw?.should be_true
			end
			
			it 'not for an uncompleted game' do
				game.human.make_move(game.square1)
				game.computer.make_move(game.square2)
				game.human.make_move(game.square3)
				game.computer.make_move(game.square4)			
				game.human.make_move(game.square5)
				game.computer.make_move(game.square6)
				game.computer.make_move(game.square7)
				game.human.make_move(game.square8)
				game.draw?.should be_false
			end

			it 'not for a won game' do
				game.human.make_move(game.square1)
				game.computer.make_move(game.square2)
				game.human.make_move(game.square3)
				game.computer.make_move(game.square4)			
				game.human.make_move(game.square5)
				game.computer.make_move(game.square6)
				game.human.make_move(game.square7)
				game.human.make_move(game.square8)
				game.human.make_move(game.square9)
				game.draw?.should be_false
			end

		end

		# xit 'returns the center on the first move' do
		# 	game.human.make_move(game.square1)
		# 	answer = game.computer.minimax(game.board)
		# 	answer.should == game.square5		
		# end

	end

end
