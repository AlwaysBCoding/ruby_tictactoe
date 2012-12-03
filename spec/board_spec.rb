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
    
    board.empty_squares.count.should == 7
  end

end
