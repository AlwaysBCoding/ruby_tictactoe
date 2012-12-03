require_relative 'lib/board.rb'
require_relative 'lib/square.rb'

board = Board.new
board.draw()

while !board.game_over? 

  print "\nChoose a number to place an 'X' there >> "
  user_move = gets.chomp

  chosen_square = board.detect_square(user_move)
  chosen_square.text_value = "X"

  board.draw()

end

puts "GAME OVER!"