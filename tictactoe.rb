require 'colorize'
require_relative 'lib/game.rb'

game = Game.new
game.board.draw()

while !game.over?

  print "\nChoose a number to place an 'X' there >> "
  user_move = gets.chomp
  
  if game.board.empty_squares.find { |sq| sq.text_value == user_move.to_i }
    chosen_square = game.board.detect_square(user_move)
    game.human.make_move(chosen_square)
    game.computer.make_move(game.computer.calculate_response(game, chosen_square)) unless game.board.empty_squares.count == 0
  else 
    puts "\nThat square has already been taken, what are you trying to pull?\n"
  end
  
  game.board.draw()

end

puts "\nGAME OVER"