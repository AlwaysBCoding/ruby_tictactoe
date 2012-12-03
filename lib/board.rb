require_relative './square.rb'

class Board
  attr_accessor :square1, :square2, :square3, :square4, :square5,
                :square6, :square7, :square8, :square9
  
  def initialize
    @square1 = Square.new(0,0,1)
    @square2 = Square.new(0,1,2)
    @square3 = Square.new(0,2,3)
    @square4 = Square.new(1,0,4)
    @square5 = Square.new(1,1,5)
    @square6 = Square.new(1,2,6)
    @square7 = Square.new(2,0,7)
    @square8 = Square.new(2,1,8)
    @square9 = Square.new(2,2,9)
  end
  
  def squares
    [ [@square1, @square2, @square3], 
      [@square4, @square5, @square6], 
      [@square7, @square8, @square9] ]
  end
  
  def draw
    visual_board = squares.map { |row| row.map { |sq| sq.text_value } }
    visual_board.each { |row| p row }
  end
    
  def empty_squares
    squares.flatten.select { |sq| sq.empty? }
  end
  
  def find_square(x,y)
    squares.flatten.detect { |sq| sq.x_value == x && sq.y_value == y }
  end
  
  def detect_square(val)
    squares.flatten.detect { |sq| sq.text_value == val.to_i }
  end
  
  def game_over?
    if empty_squares.count == 0
      return true
    else
      return false
    end
  end
  
  def make_user_move(sq)
    sq.text_value = "X"
    return sq
  end
  
  def make_computer_move(sq)
    sq.text_value = "O"
    return sq
  end
  
  def calculate_computer_response(sq)
    return first_move(sq) if empty_squares.count > 7
    return blocking_move(sq) if user_chance_to_win?
  end
  
  def first_move(sq)
    sq == square5 ? square1 : square5;
  end
  
  def user_chance_to_win?
    true
  end
  
  def blocking_move(user_sq)
    user_moves_in_current_row = squares.flatten.select { |sq| sq.x_value == user_sq.x_value && sq.text_value == "X" }
    return empty_squares.detect { |sq| sq.x_value == user_sq.x_value } if user_moves_in_current_row.count == 2 
  end
  
  # blocking_move
  # winning_move
  # take correct corner
  # take correct side
  
end