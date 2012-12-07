require_relative './square.rb'
require_relative './human.rb'
require_relative './computer.rb'

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
  
  def corners
    [@square1, @square3, @square7, @square9]
  end
  
  def sides
    [@square2, @square4, @square6, @square8]
  end
  
  def draw()
    puts "\n"
    visual_board = []
    visual_board << " #{@square1.colored_text_value} | #{@square2.colored_text_value} | #{@square3.colored_text_value} "
    visual_board << " - - - - - "
    visual_board << " #{@square4.colored_text_value} | #{@square5.colored_text_value} | #{@square6.colored_text_value} "
    visual_board << " - - - - - "
    visual_board << " #{@square7.colored_text_value} | #{@square8.colored_text_value} | #{@square9.colored_text_value} "
    visual_board.each { |row| puts row }
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
  
  def user_has_square?(sq)
    return true if sq.text_value == "X"
  end
  
  def game_over?
    [0, 1, 2].each do |i|
      computer_moves_in_row = squares.flatten.select { |sq| sq.text_value == "O" && sq.y_value == i }
      computer_moves_in_column = squares.flatten.select { |sq| sq.text_value == "O" && sq.x_value == i }      
      return true if computer_moves_in_row.count == 3 || computer_moves_in_column.count == 3
      
      next if i == 0
      computer_moves_in_diag = squares.flatten.select { |sq| sq.text_value == "O" && ( diag_for(sq) == i || diag_for(sq) == 3 ) }
      return true if computer_moves_in_diag.count == 3
    end
    
    return true if empty_squares.count == 0
    return nil
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
    unless empty_squares.count == 0
      return first_move(sq) if empty_squares.count > 7
      return winning_move if computer_chance_to_win?
      return blocking_move(sq) if user_chance_to_win?(sq)
      return take_first_side if user_starts_with_two_corners?
      return knight_solution if knight_opening?(sq)
      return take_first_corner if take_first_corner
      return take_first_side if take_first_side
    end
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
  
  def user_starts_with_two_corners?
    return true if corners.select { |sq| sq.text_value == "X" }.count == 2 && empty_squares.count == 6
  end
  
  def knight_opening?(user_sq)
    return true if corners.select { |sq| sq.text_value == "X" }.count == 1 && sides.select { |sq| sq.text_value == "X" }.count == 1 && !blocking_move(user_sq) && empty_squares.count == 6
  end
  
  def take_first_corner
    empty_squares.find { |sq| sq == square1 || sq == square3 || sq == square7 || sq == square9 }
  end
  
  def take_first_side
    empty_squares.find { |sq| sq == square2 || sq == square4 || sq == square6 || sq == square8 }
  end
  
  def knight_solution
    return square1 if ( user_has_square?(square3) && user_has_square?(square4) ) || ( user_has_square?(square7) && user_has_square?(square2) )
    return square3 if ( user_has_square?(square1) && user_has_square?(square6) ) || ( user_has_square?(square9) && user_has_square?(square2) )
    return square7 if ( user_has_square?(square9) && user_has_square?(square4) ) || ( user_has_square?(square1) && user_has_square?(square8) )
    return square9 if ( user_has_square?(square3) && user_has_square?(square8) ) || ( user_has_square?(square7) && user_has_square?(square6) )
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
  
end