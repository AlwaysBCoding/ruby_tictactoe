require_relative 'lib/board.rb'
require_relative 'lib/square.rb'

board = Board.new
board.draw()

while !board.game_over?

  print "\nChoose a number to place an 'X' there >> "
  user_move = gets.chomp
  chosen_square = board.detect_square(user_move)

  board.make_user_move(chosen_square)
  board.make_computer_move(board.calculate_computer_response(chosen_square)) unless board.empty_squares.count == 0
  board.draw()

end

puts "\nGAME OVER"