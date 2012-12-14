require 'board'
require 'human'
require 'computer'

class Game
  attr_accessor :human, :computer, :board
  
  def initialize(player2)
    @human = Human.new
    if player2 == "C"
      @computer = Computer.new
    end
    @board = Board.new
  end
  
  def over?
    [0, 1, 2].each do |i|
      computer_moves_in_row = board.squares.flatten.select { |sq| sq.text_value == "O" && sq.y_value == i }
      computer_moves_in_column = board.squares.flatten.select { |sq| sq.text_value == "O" && sq.x_value == i }      
      return true if computer_moves_in_row.count == 3 || computer_moves_in_column.count == 3
      
      next if i == 0
      computer_moves_in_diag = board.squares.flatten.select { |sq| sq.text_value == "O" && ( sq.diag_value == i || sq.diag_value == 3 ) }
      return true if computer_moves_in_diag.count == 3
    end
    
    return true if board.empty_squares.count == 0
    return nil
  end
  
  def two_corner_opening?
    return true if board.corners.select { |sq| sq.text_value == "X" }.count == 2 && board.empty_squares.count == 6
  end
      
  def knight_opening?(board, user_sq)
    return true if board.corners.select { |sq| sq.text_value == "X" }.count == 1 && board.sides.select { |sq| sq.text_value == "X" }.count == 1 && !computer.blocking_move(board, user_sq) && board.empty_squares.count == 6
  end
  
  def print_instructions(player2)
    if player2 == "C"
      print "\nYou have chosen to play against the unbeatble computer A.I. Choose a number to place an 'X' there.\n"
    elsif player2 == "H"
      "\nBREAK"
    end
  end
  
  def ending_message()
    puts "\nGAME OVER"
  end
  
end
