require 'board'
require 'human'
require 'computer'

class Game
  attr_accessor :player1, :player2, :board, :turn

  def initialize(player1, player2)
    @player1 = Human.new if player1 == "H"
    @player1 = Computer.new if player1 == "C"
    @player2 = Human.new if player2 == "H"
    @player2 = Computer.new if player2 == "C"
    @board = Board.new
    @turn = :player1
 end

	def squares
		board.squares.flatten
	end

  def switch_turn(turn)
    self.turn = :player2 if turn == :player1
    self.turn = :player1 if turn == :player2
  end

  def over?
 		return true if board.computer_win? || board.human_win? || board.empty_squares.count == 0
  end

  def make_move(player, square)
    if player == :player1
      square.text_value = "X"
    elsif player == :player2
      square.text_value = "O"
    end
    switch_turn(player)
  end

  # def two_corner_opening?
  #   return true if board.corners.select { |sq| sq.text_value == "X" }.count == 2 && board.empty_squares.count == 6
  # end

  # def knight_opening?(board, user_sq)
  #   return true if board.corners.select { |sq| sq.text_value == "X" }.count == 1 && board.sides.select { |sq| sq.text_value == "X" }.count == 1 && !computer.blocking_move(board, user_sq) && board.empty_squares.count == 6
  # end

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

	def player1_win?
	  [0, 1, 2].each do |i|
    	human_moves_in_row = board.squares.flatten.select { |sq| sq.text_value == "X" && sq.y_value == i }
    	human_moves_in_column = board.squares.flatten.select { |sq| sq.text_value == "X" && sq.x_value == i }
    	return true if human_moves_in_row.count == 3 || human_moves_in_column.count == 3

    	next if i == 0
    	human_moves_in_diag = board.squares.flatten.select { |sq| sq.text_value == "X" && ( sq.diag_value == i || sq.diag_value == 3 ) }
    	return true if human_moves_in_diag.count == 3
   end

   return false

	end

	def player2_win?
		[0, 1, 2].each do |i|
    	computer_moves_in_row = board.squares.flatten.select { |sq| sq.text_value == "O" && sq.y_value == i }
    	computer_moves_in_column = board.squares.flatten.select { |sq| sq.text_value == "O" && sq.x_value == i }
    	return true if computer_moves_in_row.count == 3 || computer_moves_in_column.count == 3

    next if i == 0
    computer_moves_in_diag = board.squares.flatten.select { |sq| sq.text_value == "O" && ( sq.diag_value == i || sq.diag_value == 3 ) }
    return true if computer_moves_in_diag.count == 3
   end

   return false
	end

	def draw?
		return true if empty_squares.count == 0 && !human_win? && !computer_win?
	end

	def method_missing(method_name, *args)
		board.send(method_name, *args)
	end

end
