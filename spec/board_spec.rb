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
      board.calculate_computer_response(chosen_square).should == board.square5 
    end
    
    it 'takes the top left if the user takes the center' do
      chosen_square = board.detect_square(5)
      board.calculate_computer_response(chosen_square).should == board.square1
    end
    
    it 'blocks the horizontal win [1,2,O]' do
      board.make_user_move(board.square1)
      board.make_computer_move(board.square5)
      board.make_user_move(board.square2)
      board.calculate_computer_response(board.square2).should == board.square3
    end
    
    it 'blocks the horizontal win [7,O,9]' do
      board.make_user_move(board.square7)
      board.make_computer_move(board.square5)
      sq = board.make_user_move(board.square9)
      board.calculate_computer_response(sq).should == board.square8
    end
    
  end

end
