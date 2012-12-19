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
				game.computer.make_moves(game.square1, game.square2, game.square3)
				game.computer_win?.should be_true
			end

			it 'for a vertical win' do
				game.computer.make_moves(game.square1, game.square4, game.square7)
				game.computer_win?.should be_true
			end

			it 'for a diagonal win' do
				game.computer.make_moves(game.square1, game.square5, game.square9)
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
				game.human.make_moves(game.square1, game.square2, game.square3)
				game.human_win?.should be_true
			end

			it 'for a vertical win' do
				game.human.make_moves(game.square1, game.square4, game.square7)
				game.human_win?.should be_true
			end

			it 'for a diagonal win' do
				game.human.make_moves(game.square1, game.square5, game.square9)
				game.human_win?.should be_true
			end

		end

		context 'a draw returns true' do
			
			it 'for a valid draw' do
				game.human.make_moves(game.square1, game.square3, game.square5, game.square8)
				game.computer.make_moves(game.square2, game.square4, game.square6, game.square7, game.square9)
				game.draw?.should be_true
			end
			
			it 'not for an uncompleted game' do
				game.human.make_moves(game.square1, game.square3, game.square5, game.square8)
				game.computer.make_moves(game.square2, game.square4, game.square6, game.square7)
				game.draw?.should be_false
			end

			it 'not for a won game' do
				game.human.make_moves(game.square1, game.square3, game.square5, game.square7, game.square8, game.square9)
				game.computer.make_moves(game.square2, game.square4, game.square6)
				game.draw?.should be_false
			end

		end

		context 'calculates a value for moves' do

			it 'can return 1 for only a winning move' do
				
			end

		end

		# xit 'returns the center on the first move' do
		# 	game.human.make_move(game.square1)
		# 	answer = game.computer.minimax(game.board)
		# 	answer.should == game.square5		
		# end

	end

end
