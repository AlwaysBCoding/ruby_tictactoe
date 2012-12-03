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
    visual_board = squares.map { |row| row.map { |sq| sq.text_value.to_s } }
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
    return winning_move if computer_chance_to_win?
    return blocking_move(sq) if user_chance_to_win?(sq)
    return take_first_corner if take_first_corner
    return take_first_side if take_first_side
  end
  
  def first_move(sq)
    sq == square5 ? square1 : square5;
  end
  
  def winning_move
    [0, 1, 2].each do |i|
      computer_moves_in_row = squares.flatten.select { |sq| sq.text_value == "O" && sq.y_value == i }
      return empty_squares.detect { |sq| sq.y_value == i } if computer_moves_in_row.count == 2
      
      computer_moves_in_column = squares.flatten.select { |sq| sq.text_value == "O" && sq.x_value == i }
      return empty_squares.detect { |sq| sq.x_value == i } if computer_moves_in_column.count == 2
      
      next if i == 0
      computer_moves_in_diag = squares.flatten.select { |sq| sq.text_value == "O" && ( diag_for(sq) == i || diag_for(sq) == 3 ) }
      return empty_squares.detect { |sq| diag_for(sq) == i } if computer_moves_in_diag.count == 2
    end
    
    return nil
  end
  
  def blocking_move(user_sq)
    user_moves_in_current_row = squares.flatten.select { |sq| sq.x_value == user_sq.x_value && sq.text_value == "X" }
    return empty_squares.detect { |sq| sq.x_value == user_sq.x_value } if user_moves_in_current_row.count == 2 
    
    user_moves_in_current_column = squares.flatten.select { |sq| sq.y_value == user_sq.y_value && sq.text_value == "X" }
    return empty_squares.detect { |sq| sq.y_value == user_sq.y_value } if user_moves_in_current_column.count == 2
    
    user_moves_in_current_diag = squares.flatten.select { |sq| sq.text_value == "X" && ( ( diag_for(sq) == diag_for(user_sq) && diag_for(user_sq) )|| diag_for(sq) == 3 ) }
    return empty_squares.detect { |sq| diag_for(sq) == diag_for(user_sq) } if user_moves_in_current_diag.count == 2
  end
  
  def computer_chance_to_win?
    return true if winning_move
  end
  
  def user_chance_to_win?(user_sq)
    return true if blocking_move(user_sq)
  end
  
  def take_first_corner
    empty_squares.find { |sq| sq == square1 || sq == square3 || sq == square7 || sq == square9 }
  end
  
  def take_first_side
    empty_squares.find { |sq| sq == square2 || sq == square4 || sq == square6 || sq == square8 }
  end
  
  def diag_for(sq)
    case
      when sq == square3
        2
      when sq == square7
        2
      when sq == square1
        1
      when sq == square9
        1
      when sq == square5
        3
    end
  end
  
  # take correct corner
  # take correct side
  
end