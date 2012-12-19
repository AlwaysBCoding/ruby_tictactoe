require 'square'
require 'human'
require 'computer'

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
	
	def human_squares
		squares.flatten.select { |sq| sq.text_value == "X" }
	end

	def computer_squares
		squares.flatten.select { |sq| sq.text_value == "O" }
	end

  def find_square(x,y)
    squares.flatten.detect { |sq| sq.x_value == x && sq.y_value == y }
  end
  
  def detect_square(val)
    squares.flatten.detect { |sq| sq.text_value == val.to_i }
  end

	def human_win?
	  [0, 1, 2].each do |i|
    	human_moves_in_row = squares.flatten.select { |sq| sq.text_value == "X" && sq.y_value == i }
    	human_moves_in_column = squares.flatten.select { |sq| sq.text_value == "X" && sq.x_value == i }      
    	return true if human_moves_in_row.count == 3 || human_moves_in_column.count == 3
      
    	next if i == 0
    	human_moves_in_diag = squares.flatten.select { |sq| sq.text_value == "X" && ( sq.diag_value == i || sq.diag_value == 3 ) }
    	return true if human_moves_in_diag.count == 3
   end
    
   return false

	end

	def computer_win?
		[0, 1, 2].each do |i|
    	computer_moves_in_row = squares.flatten.select { |sq| sq.text_value == "O" && sq.y_value == i }
    	computer_moves_in_column = squares.flatten.select { |sq| sq.text_value == "O" && sq.x_value == i }      
    	return true if computer_moves_in_row.count == 3 || computer_moves_in_column.count == 3
      
    next if i == 0
    computer_moves_in_diag = squares.flatten.select { |sq| sq.text_value == "O" && ( sq.diag_value == i || sq.diag_value == 3 ) }
    return true if computer_moves_in_diag.count == 3
   end
    
   return false
	end

	def draw?
		return true if empty_squares.count == 0 && !human_win? && !computer_win?
	end

end
