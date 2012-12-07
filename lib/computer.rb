class Computer
  
  def has_square?(sq)
    return true if sq.text_value == "O"
  end
  
  def winning_move(board)
    [0, 1, 2].each do |i|
      moves_in_row = board.squares.flatten.select { |sq| sq.text_value == "O" && sq.y_value == i }
      return board.empty_squares.detect { |sq| sq.y_value == i } if moves_in_row.count == 2
      
      moves_in_column = board.squares.flatten.select { |sq| sq.text_value == "O" && sq.x_value == i }
      return board.empty_squares.detect { |sq| sq.x_value == i } if moves_in_column.count == 2
      
      next if i == 0
      moves_in_diag = board.squares.flatten.select { |sq| sq.text_value == "O" && ( sq.diag_value == i || sq.diag_value == 3 ) }
      return board.empty_squares.detect { |sq| sq.diag_value == i } if moves_in_diag.count == 2
    end
    
    return nil
  end
  
  def chance_to_win?(board)
    return true if winning_move(board)
  end
  
  def blocking_move(board, user_sq)
    user_moves_in_current_row = board.squares.flatten.select { |sq| sq.x_value == user_sq.x_value && sq.text_value == "X" }
    return board.empty_squares.detect { |sq| sq.x_value == user_sq.x_value } if user_moves_in_current_row.count == 2 
    
    user_moves_in_current_column = board.squares.flatten.select { |sq| sq.y_value == user_sq.y_value && sq.text_value == "X" }
    return board.empty_squares.detect { |sq| sq.y_value == user_sq.y_value } if user_moves_in_current_column.count == 2
    
    user_moves_in_current_diag = board.squares.flatten.select { |sq| sq.text_value == "X" && ( ( sq.diag_value == user_sq.diag_value && user_sq.diag_value )|| sq.diag_value == 3 ) }
    return board.empty_squares.detect { |sq| sq.diag_value == user_sq.diag_value } if user_moves_in_current_diag.count == 2
    
    return nil
  end
  
  def take_first_corner(board)
    board.empty_squares.find { |sq| sq == board.square1 || sq == board.square3 || sq == board.square7 || sq == board.square9 }
  end
  
  def take_first_side(board)
    board.empty_squares.find { |sq| sq == board.square2 || sq == board.square4 || sq == board.square6 || sq == board.square8 }
  end
  
  
end