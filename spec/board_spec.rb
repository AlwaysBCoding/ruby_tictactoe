require 'colorize'
require 'board'

describe 'Board' do

  let(:board) { Board.new }

  it 'creates a board' do
    board.should be_an_instance_of(Board)
  end

  it 'can draw a board' do
    board.draw()
  end

  it 'has nine squares' do
    board.empty_squares.count.should == 9
  end

  it 'can find a square' do
    square = board.find_square(1,0)
    square.should == board.square2
  end

  it 'can sucessfully count the empty squares' do
    board.square1.text_value = "X"
    board.square2.text_value = "O"
    board.square3.text_value = "~"

    board.empty_squares.count.should == 7
  end
end # Board
