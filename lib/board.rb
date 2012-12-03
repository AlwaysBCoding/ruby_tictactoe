require_relative './square.rb'

class Board
  attr_accessor :square1, :square2, :square3, :square4, :square5,
                :square6, :square7, :square8, :square9
  
  def initialize
    @square1 = Square.new(0,0)
    @square2 = Square.new(0,1)
    @square3 = Square.new(0,2)
    @square4 = Square.new(1,0)
    @square5 = Square.new(1,1)
    @square6 = Square.new(1,2)
    @square7 = Square.new(2,0)
    @square8 = Square.new(2,1)
    @square9 = Square.new(2,2)
  end
  
  def squares
    [ [@square1, @square2, @square3], 
      [@square4, @square5, @square6], 
      [@square7, @square8, @square9] ]
  end
  
  def draw
    visual_board = squares.map { |row| row.map { |sq| sq.text_value || "~" } }
    visual_board.each { |row| p row }
  end
  
  def count_squares
    squares.flatten.count
  end
  
  def find_square(x,y)
    squares.flatten.detect { |sq| sq.x_value == x && sq.y_value == y }
  end
  
end