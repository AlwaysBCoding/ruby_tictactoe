require_relative './square.rb'
require_relative './human.rb'
require_relative './computer.rb'

class Board
  attr_accessor :square1, :square2, :square3, :square4, :square5,
                :square6, :square7, :square8, :square9, :human, :computer
  
  def initialize
    @square1 = Square.new(0,0,1,1)
    @square2 = Square.new(0,1,nil,2)
    @square3 = Square.new(0,2,2,3)
    @square4 = Square.new(1,0,nil,4)
    @square5 = Square.new(1,1,3,5)
    @square6 = Square.new(1,2,nil,6)
    @square7 = Square.new(2,0,2,7)
    @square8 = Square.new(2,1,nil,8)
    @square9 = Square.new(2,2,1,9)
    @human = Human.new
    @computer = Computer.new
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
  
  def game_over?
    [0, 1, 2].each do |i|
      computer_moves_in_row = squares.flatten.select { |sq| sq.text_value == "O" && sq.y_value == i }
      computer_moves_in_column = squares.flatten.select { |sq| sq.text_value == "O" && sq.x_value == i }      
      return true if computer_moves_in_row.count == 3 || computer_moves_in_column.count == 3
      
      next if i == 0
      computer_moves_in_diag = squares.flatten.select { |sq| sq.text_value == "O" && ( sq.diag_value == i || sq.diag_value == 3 ) }
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
  
  def calculate_computer_response(board=nil, sq)
    unless empty_squares.count == 0
      return first_move(sq) if empty_squares.count > 7
      return @computer.winning_move(board) if @computer.chance_to_win?(board)
      return @computer.blocking_move(board, sq) if @computer.blocking_move(board, sq)
      return @computer.take_first_side(board) if user_starts_with_two_corners?
      return knight_solution if knight_opening?(board, sq)
      return @computer.take_first_corner(board) if @computer.take_first_corner(board)
      return @computer.take_first_side(board) if @computer.take_first_side(board)
    end
  end
  
  def first_move(sq)
    sq == square5 ? square1 : square5;
  end
    
  def user_chance_to_win?(user_sq)
    return true if blocking_move(user_sq)
  end
  
  def user_starts_with_two_corners?
    return true if corners.select { |sq| sq.text_value == "X" }.count == 2 && empty_squares.count == 6
  end
  
  def knight_opening?(board, user_sq)
    return true if corners.select { |sq| sq.text_value == "X" }.count == 1 && sides.select { |sq| sq.text_value == "X" }.count == 1 && !@computer.blocking_move(board, user_sq) && empty_squares.count == 6
  end

  def knight_solution
    return square1 if ( @human.has_square?(square3) && @human.has_square?(square4) ) || ( @human.has_square?(square7) && @human.has_square?(square2) )
    return square3 if ( @human.has_square?(square1) && @human.has_square?(square6) ) || ( @human.has_square?(square9) && @human.has_square?(square2) )
    return square7 if ( @human.has_square?(square9) && @human.has_square?(square4) ) || ( @human.has_square?(square1) && @human.has_square?(square8) )
    return square9 if ( @human.has_square?(square3) && @human.has_square?(square8) ) || ( @human.has_square?(square7) && @human.has_square?(square6) )
  end
  
end