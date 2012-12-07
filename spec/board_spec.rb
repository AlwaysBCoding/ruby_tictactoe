require 'board'

describe 'Board' do
  
  let(:board) { Board.new }
  
  it 'creates a board' do
    board.should be_an_instance_of(Board)
  end
  
  it 'has nine squares' do
    board.empty_squares.count.should == 9
  end
  
  it 'can find a square' do
    square = board.find_square(0,1)
    square.should == board.square2
  end
  
  it 'can sucessfully count the empty squares' do
    board.square1.text_value = "X"
    board.square2.text_value = "O"
    board.square3.text_value = "~"
    
    board.empty_squares.count.should == 7
  end
  
  describe "computer move response" do
    
    it 'takes the center on the first move' do
      chosen_square = board.detect_square(1)
      board.calculate_computer_response(board, chosen_square).should == board.square5 
    end
    
    it 'takes the top left if the user takes the center' do
      chosen_square = board.detect_square(5)
      board.calculate_computer_response(board, chosen_square).should == board.square1
    end
    
    it 'blocks the horizontal win [1,2,O]' do
      board.human.make_move(board.square1)
      board.computer.make_move(board.square5)
      sq = board.human.make_move(board.square2)
      board.calculate_computer_response(board, sq).should == board.square3
    end
    
    it 'blocks the horizontal win [7,O,9]' do
      board.human.make_move(board.square7)
      board.computer.make_move(board.square5)
      sq = board.human.make_move(board.square9)
      board.calculate_computer_response(board, sq).should == board.square8
    end
    
    it 'blocks the vertical win [1,4,O]' do
      board.human.make_move(board.square1)
      board.computer.make_move(board.square5)
      sq = board.human.make_move(board.square4)
      board.calculate_computer_response(board, sq).should == board.square7
    end
    
    it 'blocks the vertical win [O,6,9]' do
      board.human.make_move(board.square6)
      board.computer.make_move(board.square5)
      sq = board.human.make_move(board.square9)
      board.calculate_computer_response(board, sq).should == board.square3
    end
    
    it 'blocks the diagonal win [3,5,O]' do
      board.human.make_move(board.square5)
      board.computer.make_move(board.square1)
      sq = board.human.make_move(board.square3)
      board.calculate_computer_response(board, sq).should == board.square7
    end
    
    it 'blocks the diagonal win [7,5,O]' do
      board.human.make_move(board.square5)
      board.computer.make_move(board.square1)
      sq = board.human.make_move(board.square7)
      board.calculate_computer_response(board, sq).should == board.square3
    end
    
    it 'takes the horizontal winning move [1,2,O]' do
      board.human.make_move(board.square5)
      board.computer.make_move(board.square1)
      board.human.make_move(board.square9)
      board.computer.make_move(board.square2)
      sq = board.human.make_move(board.square7)
      board.calculate_computer_response(board, sq).should == board.square3
    end
    
    it 'takes the vertical winning move [O,5,8]' do
      board.human.make_move(board.square1)
      board.computer.make_move(board.square5)
      board.human.make_move(board.square9)
      board.computer.make_move(board.square8)
      sq = board.human.make_move(board.square4)
      board.calculate_computer_response(board, sq).should == board.square2
    end
    
    it 'takes the diagonal winning move [1,5,O]' do
      board.human.make_move(board.square3)
      board.computer.make_move(board.square5)
      board.human.make_move(board.square7)
      board.computer.make_move(board.square1)
      sq = board.human.make_move(board.square2)
      board.calculate_computer_response(board, sq).should == board.square9
    end
    
    it 'prevents the two corner opening [1,9,O]' do
      board.human.make_move(board.square1)
      board.computer.make_move(board.square5)
      sq = board.human.make_move(board.square9)
      board.calculate_computer_response(board, sq).should == board.square2
    end
    
    it 'prevents the two corner opening [3,7,O]' do
      board.human.make_move(board.square3)
      board.computer.make_move(board.square5)
      sq = board.human.make_move(board.square7)
      board.calculate_computer_response(board, sq).should == board.square2
    end
    
    describe "knight opening" do
      it 'prevents the knight opening [3,8,O]' do
        board.human.make_move(board.square3)
        board.computer.make_move(board.square5)
        sq = board.human.make_move(board.square8)
        board.knight_opening?(board, sq).should be_true
        board.calculate_computer_response(board, sq).should == board.square9
      end          
      
      it 'prevents the knight opening [3,4,O]' do
        board.human.make_move(board.square3)
        board.computer.make_move(board.square5)
        sq = board.human.make_move(board.square4)
        board.knight_opening?(board, sq).should be_true
        board.calculate_computer_response(board, sq).should == board.square1
      end    
    
      it 'prevents the knight opening [7,6,O]' do
        board.human.make_move(board.square7)
        board.computer.make_move(board.square5)
        sq = board.human.make_move(board.square6)
        board.knight_opening?(board, sq).should be_true
        board.calculate_computer_response(board, sq).should == board.square9
      end    
      
      it 'prevents the knight opening [7,2,O]' do
        board.human.make_move(board.square7)
        board.computer.make_move(board.square5)
        sq = board.human.make_move(board.square2)
        board.knight_opening?(board, sq).should be_true
        board.calculate_computer_response(board, sq).should == board.square1
      end    
    
      it 'prevents the knight opening [1,8,O]' do
        board.human.make_move(board.square1)
        board.computer.make_move(board.square5)
        sq = board.human.make_move(board.square8)
        board.knight_opening?(board, sq).should be_true
        board.calculate_computer_response(board, sq).should == board.square7
      end   
    
      it 'prevents the knight opening [1,6,O]' do
        board.human.make_move(board.square1)
        board.computer.make_move(board.square5)
        sq = board.human.make_move(board.square6)
        board.knight_opening?(board, sq).should be_true
        board.calculate_computer_response(board, sq).should == board.square3
      end    
    
      it 'prevents the knight opening [9,2,O]' do
        board.human.make_move(board.square9)
        board.computer.make_move(board.square5)
        sq = board.human.make_move(board.square2)
        board.knight_opening?(board, sq).should be_true
        board.calculate_computer_response(board, sq).should == board.square3
      end    
    
      it 'prevents the knight opening [9,4,O]' do
        board.human.make_move(board.square9)
        board.computer.make_move(board.square5)
        sq = board.human.make_move(board.square4)
        board.knight_opening?(board, sq).should be_true
        board.calculate_computer_response(board, sq).should == board.square7
      end
      
    end # knight opening

  end # calculate computer response
  
  describe '#game_over?' do
    
    it 'ends the game at a horizontal win' do
      board.computer.make_move(board.square1)
      board.computer.make_move(board.square2)
      board.computer.make_move(board.square3)
      board.game_over?.should be_true
    end
    
    it 'ends the game at a vertical win' do
      board.computer.make_move(board.square3)
      board.computer.make_move(board.square6)
      board.computer.make_move(board.square9)
      board.game_over?.should be_true
    end
    
    it 'ends the game at a diagonal win' do
      board.computer.make_move(board.square3)
      board.computer.make_move(board.square5)
      board.computer.make_move(board.square7)
      board.game_over?.should be_true
    end
    
    it 'ends the game at a draw' do
      9.times do |i|
        board.human.make_move(board.send("square#{i+1}".to_sym))
      end
      board.game_over?.should be_true 
    end
    
    it "doesn't end the game prematurely" do
      8.times do |i|
        board.human.make_move(board.send("square#{i+1}".to_sym))
      end
      board.game_over?.should be_false
    end
    
  end # #game_over? 

end # Board
