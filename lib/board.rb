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
    (@size**2).times do |i|
      number = i + 1
      x_axis = i % @size
      y_axis = i / @size
      if @size == 3
        if number == 1 || number == 9
          diag = 1
        elsif number == 3 || number == 7
          diag = 2
        elsif number == 5
          diag = 3
        else
          diag = nil
        end
      elsif @size == 4
        if number == 1 || number == 6 || number == 11 || number == 16
          diag = 1
        elsif number == 4 || number == 7 || number == 10 || number == 13
          diag = 2
        else
          diag = nil
        end
      end
      instance_variable_set("@square#{i+1}".to_sym, Square.new(x_axis,y_axis,diag,"#{number}",number))
    end
  end

  def squares
    array = []
    @size.times { array << [] }
    (@size**2).times do |i|
      array[(i % @size)] << instance_variable_get("@square#{i+1}".to_sym)
    end
    return array
  end

  def draw
    puts "\n"
    visual_board = []
    (@size*2 - 1).times do |i|
      if i.even?
        string = ""
        @size.times do |i2|
          string += " #{instance_variable_get("@square#{(i2+1)+((i/2)*@size)}".to_sym).colored_text_value} "
          string += "|" unless i2+1 == @size
        end
        visual_board << string
      elsif i.odd?
        visual_board << " -" * (@size*2)
      end
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
    squares.flatten.detect { |sq| sq.text_value.to_s == val.to_s }
  end

	def player1_win?
	  (0..@size-1).each do |i|
    	human_moves_in_row = squares.flatten.select { |sq| sq.text_value == "X" && sq.y_value == i }
    	human_moves_in_column = squares.flatten.select { |sq| sq.text_value == "X" && sq.x_value == i }
    	return true if human_moves_in_row.count == @size || human_moves_in_column.count == @size

    	next if i == 0
    	human_moves_in_diag = squares.flatten.select { |sq| sq.text_value == "X" && ( sq.diag_value == i || sq.diag_value == 3 ) }
    	return true if human_moves_in_diag.count == @size
   end

   return false

	end

	def player2_win?
		(0..@size-1).each do |i|
    	computer_moves_in_row = squares.flatten.select { |sq| sq.text_value == "O" && sq.y_value == i }
    	computer_moves_in_column = squares.flatten.select { |sq| sq.text_value == "O" && sq.x_value == i }
    	return true if computer_moves_in_row.count == @size || computer_moves_in_column.count == @size

    next if i == 0
    computer_moves_in_diag = squares.flatten.select { |sq| sq.text_value == "O" && ( sq.diag_value == i || sq.diag_value == 3 ) }
    return true if computer_moves_in_diag.count == @size
   end

   return false
	end

	def draw?
		return true if empty_squares.count == 0 && !player1_win? && !player2_win?
	end

end
