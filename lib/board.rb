require 'square'
require 'human'
require 'computer'

class Board
  attr_accessor :square1, :square2, :square3, :square4, :square5,
                :square6, :square7, :square8, :square9, :square10,
                :square11, :square12, :square13, :square14, :square15, :square16,
                :human, :computer, :size

  def initialize(size=3)
    @size = size
    if @size == 3
      @square1 = Square.new(0,0,1,"1",1)
      @square2 = Square.new(1,0,nil,"2",2)
      @square3 = Square.new(2,0,2,"3",3)
      @square4 = Square.new(0,1,nil,"4",4)
      @square5 = Square.new(1,1,3,"5",5)
      @square6 = Square.new(2,1,nil,"6",6)
      @square7 = Square.new(0,2,2,"7",7)
      @square8 = Square.new(1,2,nil,"8",8)
      @square9 = Square.new(2,2,1,"9",9)
    elsif @size == 4
      @square1 = Square.new(0,0,nil,"01",1)
      @square2 = Square.new(1,0,nil,"02",2)
      @square3 = Square.new(2,0,nil,"03",3)
      @square4 = Square.new(3,0,nil,"04",4)
      @square5 = Square.new(0,1,nil,"05",5)
      @square6 = Square.new(1,1,nil,"06",6)
      @square7 = Square.new(2,1,nil,"07",7)
      @square8 = Square.new(3,1,nil,"08",8)
      @square9 = Square.new(0,2,nil,"09",9)
      @square10 = Square.new(1,2,nil,"10",10)
      @square11 = Square.new(2,2,nil,"11",11)
      @square12 = Square.new(3,2,nil,"12",12)
      @square13 = Square.new(0,3,nil,"13",13)
      @square14 = Square.new(1,3,nil,"14",14)
      @square15 = Square.new(2,3,nil,"15",15)
      @square16 = Square.new(3,3,nil,"16",16)
    end
  end

  def squares
    if @size == 3
      [ [@square1, @square2, @square3],
        [@square4, @square5, @square6],
        [@square7, @square8, @square9] ]
    elsif @size == 4
      [ [@square1, @square2, @square3, @square4],
        [@square5, @square6, @square7, @square8],
        [@square9, @square10, @square11, @square12],
        [@square13, @square14, @square15, @square16] ]
    end
  end

  def draw
    puts "\n"
    visual_board = []
    if @size == 3
      visual_board << " #{@square1.colored_text_value} | #{@square2.colored_text_value} | #{@square3.colored_text_value} "
      visual_board << " - - - - - "
      visual_board << " #{@square4.colored_text_value} | #{@square5.colored_text_value} | #{@square6.colored_text_value} "
      visual_board << " - - - - - "
      visual_board << " #{@square7.colored_text_value} | #{@square8.colored_text_value} | #{@square9.colored_text_value} "
    elsif @size == 4
      visual_board << " #{@square1.colored_text_value} | #{@square2.colored_text_value} | #{@square3.colored_text_value} | #{@square4.colored_text_value } "
      visual_board << " - - - - - - - - - "
      visual_board << " #{@square5.colored_text_value} | #{@square6.colored_text_value} | #{@square7.colored_text_value} | #{@square8.colored_text_value } "
      visual_board << " - - - - - - - - - "
      visual_board << " #{@square9.colored_text_value} | #{@square10.colored_text_value} | #{@square11.colored_text_value} | #{@square12.colored_text_value } "
      visual_board << " - - - - - - - - - "
      visual_board << " #{@square13.colored_text_value} | #{@square14.colored_text_value} | #{@square15.colored_text_value} | #{@square16.colored_text_value } "
    end
    visual_board.each { |row| puts row }
  end

  def empty_squares
    squares.flatten.select { |sq| sq.empty? }
  end

  def find_square(x,y)
    squares.flatten.detect { |sq| sq.x_value == x && sq.y_value == y }
  end

  def detect_square(val)
    squares.flatten.detect { |sq| sq.text_value == val }
  end

	def player1_win?
	  (0..@size-1).each do |i|
    	human_moves_in_row = squares.flatten.select { |sq| sq.text_value == "X" && sq.y_value == i }
    	human_moves_in_column = squares.flatten.select { |sq| sq.text_value == "X" && sq.x_value == i }
    	return true if human_moves_in_row.count == 3 || human_moves_in_column.count == 3

    	next if i == 0
    	human_moves_in_diag = squares.flatten.select { |sq| sq.text_value == "X" && ( sq.diag_value == i || sq.diag_value == 3 ) }
    	return true if human_moves_in_diag.count == 3
   end

   return false

	end

	def player2_win?
		(0..@size-1).each do |i|
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
		return true if empty_squares.count == 0 && !player1_win? && !player2_win?
	end

end
