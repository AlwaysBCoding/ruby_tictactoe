require 'board'

describe 'Board' do
  
  let(:board) { Board.new }
  
  it 'creates a board' do
    board = Board.new
    board.should be_an_instance_of(Board)
  end
  
  it 'has nine squares' do
    board.count_squares.should == 9
  end
  
end
