require 'game'
require 'computer'

describe 'Computer' do
  
  let(:game) { Game.new }
  
  describe "#calculate_response" do
    
    it 'takes the center on the first move' do
      chosen_square = game.human.make_move(game.board.square1)
      game.computer.calculate_response(game, chosen_square).should == game.board.square5 
    end
    
    it 'takes the top left if the user takes the center' do
      chosen_square = game.human.make_move(game.board.square5)
      game.computer.calculate_response(game, chosen_square).should == game.board.square1
    end
    
    it 'blocks the horizontal win [1,2,O]' do
      game.human.make_move(game.board.square1)
      game.computer.make_move(game.board.square5)
      sq = game.human.make_move(game.board.square2)
      game.computer.calculate_response(game, sq).should == game.board.square3
    end
    
    it 'blocks the horizontal win [7,O,9]' do
      game.human.make_move(game.board.square7)
      game.computer.make_move(game.board.square5)
      sq = game.human.make_move(game.board.square9)
      game.computer.calculate_response(game, sq).should == game.board.square8
    end
    
    it 'blocks the vertical win [1,4,O]' do
      game.human.make_move(game.board.square1)
      game.computer.make_move(game.board.square5)
      sq = game.human.make_move(game.board.square4)
      game.computer.calculate_response(game, sq).should == game.board.square7
    end
    
    it 'blocks the vertical win [O,6,9]' do
      game.human.make_move(game.board.square6)
      game.computer.make_move(game.board.square5)
      sq = game.human.make_move(game.board.square9)
      game.computer.calculate_response(game, sq).should == game.board.square3
    end
    
    it 'blocks the vertical win [3,O,9]' do
      game.human.make_move(game.board.square1)
      game.computer.make_move(game.board.square5)
      game.human.make_move(game.board.square9)
      game.computer.make_move(game.board.square2)
      game.human.make_move(game.board.square8)
      game.computer.make_move(game.board.square7)
      sq = game.human.make_move(game.board.square3)
      game.computer.blocking_move(game.board, sq).should be_true
      game.computer.calculate_response(game, sq).should == game.board.square6
    end
    
    it 'blocks the diagonal win [3,5,O]' do
      game.human.make_move(game.board.square5)
      game.computer.make_move(game.board.square1)
      sq = game.human.make_move(game.board.square3)
      game.computer.calculate_response(game, sq).should == game.board.square7
    end
    
    it 'blocks the diagonal win [7,5,O]' do
      game.human.make_move(game.board.square5)
      game.computer.make_move(game.board.square1)
      sq = game.human.make_move(game.board.square7)
      game.computer.calculate_response(game, sq).should == game.board.square3
    end
    
    it 'takes the horizontal winning move [1,2,O]' do
      game.human.make_move(game.board.square5)
      game.computer.make_move(game.board.square1)
      game.human.make_move(game.board.square9)
      game.computer.make_move(game.board.square2)
      sq = game.human.make_move(game.board.square7)
      game.computer.calculate_response(game, sq).should == game.board.square3
    end
    
    it 'takes the vertical winning move [O,5,8]' do
      game.human.make_move(game.board.square1)
      game.computer.make_move(game.board.square5)
      game.human.make_move(game.board.square9)
      game.computer.make_move(game.board.square8)
      sq = game.human.make_move(game.board.square4)
      game.computer.calculate_response(game, sq).should == game.board.square2
    end
    
    it 'takes the diagonal winning move [1,5,O]' do
      game.human.make_move(game.board.square3)
      game.computer.make_move(game.board.square5)
      game.human.make_move(game.board.square7)
      game.computer.make_move(game.board.square1)
      sq = game.human.make_move(game.board.square2)
      game.computer.calculate_response(game, sq).should == game.board.square9
    end
    
    it 'prevents the two corner opening [1,9,O]' do
      game.human.make_move(game.board.square1)
      game.computer.make_move(game.board.square5)
      sq = game.human.make_move(game.board.square9)
      game.computer.calculate_response(game, sq).should == game.board.square2
    end
    
    it 'prevents the two corner opening [3,7,O]' do
      game.human.make_move(game.board.square3)
      game.computer.make_move(game.board.square5)
      sq = game.human.make_move(game.board.square7)
      game.computer.calculate_response(game, sq).should == game.board.square2
    end
    
    describe "knight opening" do
      
      it 'prevents the knight opening [3,8,O]' do
        game.human.make_move(game.board.square3)
        game.computer.make_move(game.board.square5)
        sq = game.human.make_move(game.board.square8)
        game.knight_opening?(game.board, sq).should be_true
        game.computer.calculate_response(game, sq).should == game.board.square9
      end          
      
      it 'prevents the knight opening [3,4,O]' do
        game.human.make_move(game.board.square3)
        game.computer.make_move(game.board.square5)
        sq = game.human.make_move(game.board.square4)
        game.knight_opening?(game.board, sq).should be_true
        game.computer.calculate_response(game, sq).should == game.board.square1
      end    
    
      it 'prevents the knight opening [7,6,O]' do
        game.human.make_move(game.board.square7)
        game.computer.make_move(game.board.square5)
        sq = game.human.make_move(game.board.square6)
        game.knight_opening?(game.board, sq).should be_true
        game.computer.calculate_response(game, sq).should == game.board.square9
      end    
      
      it 'prevents the knight opening [7,2,O]' do
        game.human.make_move(game.board.square7)
        game.computer.make_move(game.board.square5)
        sq = game.human.make_move(game.board.square2)
        game.knight_opening?(game.board, sq).should be_true
        game.computer.calculate_response(game, sq).should == game.board.square1
      end    
    
      it 'prevents the knight opening [1,8,O]' do
        game.human.make_move(game.board.square1)
        game.computer.make_move(game.board.square5)
        sq = game.human.make_move(game.board.square8)
        game.knight_opening?(game.board, sq).should be_true
        game.computer.calculate_response(game, sq).should == game.board.square7
      end   
    
      it 'prevents the knight opening [1,6,O]' do
        game.human.make_move(game.board.square1)
        game.computer.make_move(game.board.square5)
        sq = game.human.make_move(game.board.square6)
        game.knight_opening?(game.board, sq).should be_true
        game.computer.calculate_response(game, sq).should == game.board.square3
      end    
    
      it 'prevents the knight opening [9,2,O]' do
        game.human.make_move(game.board.square9)
        game.computer.make_move(game.board.square5)
        sq = game.human.make_move(game.board.square2)
        game.knight_opening?(game.board, sq).should be_true
        game.computer.calculate_response(game, sq).should == game.board.square3
      end    
    
      it 'prevents the knight opening [9,4,O]' do
        game.human.make_move(game.board.square9)
        game.computer.make_move(game.board.square5)
        sq = game.human.make_move(game.board.square4)
        game.knight_opening?(game.board, sq).should be_true
        game.computer.calculate_response(game, sq).should == game.board.square7
      end
      
    end # knight opening

  end # calculate computer response
  
end