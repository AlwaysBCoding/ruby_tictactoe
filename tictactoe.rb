require 'colorize'
require_relative 'lib/board.rb'

board = Board.new
board.draw()

while !board.game_over?

  print "\nChoose a number to place an 'X' there >> "
  user_move = gets.chomp
  
  if board.empty_squares.find { |sq| sq.text_value == user_move.to_i }
    chosen_square = board.detect_square(user_move)

    board.make_user_move(chosen_square)
    board.computer.make_move(board.calculate_computer_response(board, chosen_square)) unless board.empty_squares.count == 0
    board.draw()
  else 
    puts "\nThat square has already been taken, what are you trying to pull?\n"
    board.draw()
  end

end

puts "\nGAME OVER"