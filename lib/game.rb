require 'board'
require 'human'
require 'computer'

class Game
  attr_accessor :player1, :player2, :board, :turn

  def initialize(player1, player2, size=3)
    @player1 = Human.new if player1 == "H"
    @player1 = Computer.new if player1 == "C"
    @player2 = Human.new if player2 == "H"
    @player2 = Computer.new if player2 == "C"
    @board = Board.new(size)
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
 		return true if board.player1_win? || board.player2_win? || board.empty_squares.count == 0
  end

  def make_move(player, square)
    if player == :player1
      square.text_value = "X"
    elsif player == :player2
      square.text_value = "O"
    end
    switch_turn(player)
  end

  def print_instructions(player1, player2)
    if player1 == "C" && player2 == "C"
      print "\nTwo Computers will duel to the death...\n"
    elsif player1 == "H" && player2 == "C" || player1 == "C" && player2 == "H"
      print "\nYou have chosen to play against the unbeatble computer A.I. Choose a number to place your mark there...\n"
    elsif player1 == "H" && player2 == "H"
      print "\nIt's a duel between two mortals...\n"
    end
  end

  def ending_message()
    puts "\nGAME OVER"
  end

	def draw?
		return true if empty_squares.count == 0 && !p1_win? && !p2_win?
	end

	def method_missing(method_name, *args)
		board.send(method_name, *args)
	end

end
