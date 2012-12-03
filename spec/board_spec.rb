require 'board'

describe 'Board' do
  
  it 'creates a board' do
    board = Board.new
    board.should be_an_instance_of(Board)
  end
  
end
