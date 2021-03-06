$: << File.expand_path(File.dirname(__FILE__) + "/../lib")
require 'colorize'
require 'game'
require 'board'
play_again = 'y'
counter = 0

print "\nPlayer1 is a: Human (H) or Computer (C) >> "
player1 = gets.chomp.upcase
print "\nPlayer2 is a: Human (H) or Computer (C) >> "
player2 = gets.chomp.upcase
print "\nChoose Board Size (3) or (4) >> "
board_size = gets.chomp

while play_again != 'n'

  game = Game.new(player1, player2, board_size.to_i)
  game.print_instructions(player1, player2) if counter == 0
  game.board.draw()
  counter += 1

  while !game.over?

    if game.send(game.turn).is_a?(Human)

      print "\n#{game.turn}: Make your move >> "
      user_move = gets.chomp

      if game.board.empty_squares.find { |sq| sq.text_value.to_s == user_move.to_s }
        chosen_square = game.board.detect_square(user_move)
        game.make_move(game.turn, chosen_square)
      else
        puts "\nThat square has already been taken, what are you trying to pull?\n"
      end

      game.board.draw()

    elsif game.send(game.turn).is_a?(Computer)

      chosen_square = game.send(game.turn).minimax(game, game.turn, game.turn)
      game.make_move(game.turn, chosen_square)

      game.board.draw()
    end

  end

  game.ending_message()

  print "\nPlay Again? y/n >> "
  play_again = gets.chomp.downcase ; break if play_again == 'n'

end
