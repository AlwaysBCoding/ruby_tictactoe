$: << '~/Desktop/kata/tictactoe'
require 'colorize'
require 'game'
require 'board'
play_again = 'y'
counter = 0

print "\nPlayer1 is a: Human (H) or Computer (C) >> "
player1 = gets.chomp.upcase
print "\nPlayer2 is a: Human (H) or Computer (C) >> "
player2 = gets.chomp.upcase

while play_again != 'n'

  game = Game.new(player2)
  game.print_instructions(player2) if counter == 0
  game.board.draw()
  counter += 1

  while !game.over?

    print "\nMake your move >> "
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

  game.ending_message()

  print "\nPlay Again? y/n >> "
  play_again = gets.chomp.downcase ; break if play_again == 'n'

end
