class Computer

  def has_square?(sq)
    return true if sq.text_value == "O"
  end

  def make_move(sq, turn)
    if turn == :player1
      sq.text_value = "X"
    elsif turn == :player2
      sq.text_value = "O"
    end
    return sq
  end

	def undo_move(sq)
		sq.text_value = sq.number
	end

	def make_moves(*args)
		args.each do |sq|
			sq.text_value = "O"
		end
	end

  def score_board(game, player)
    return 1 if game.board.send("#{player}_win?".to_sym)
    return -1 if game.board.send("#{opponent(player)}_win?".to_sym)
    return 0 if game.board.draw?
  end

  def opponent(player)
    return :player2 if player == :player1
    return :player1 if player == :player2
  end

  def switch_turn(turn)
    return :player2 if turn == :player1
    return :player1 if turn == :player2
  end

  def minimax(game, player, turn)
    square = get_minimax_square(game, player, turn)
    return game.send(square)
  end

  def get_minimax_scores(game, player, turn)
    scores = []
    return score_board(game, player) if game.over?

    game.empty_squares.each do |move|
      make_move(move, turn)
      minimax_scores = get_minimax_scores(game, player, switch_turn(turn))

      if minimax_scores.class == Fixnum
        scores << minimax_scores
      elsif player == turn
        scores << minimax_scores.min
      elsif player != turn
        scores << minimax_scores.max
      end

      undo_move(move)
    end

    return scores
  end

  def get_minimax_square(game, player, turn)
    moves_with_score = {}
    scores = get_minimax_scores(game, player, turn)

    game.empty_squares.each_with_index do |move, i|
      moves_with_score["square#{move.number}".to_sym] = scores[i]
    end

    max = moves_with_score.values.max
    puts moves_with_score
    return moves_with_score.select { |k,v| v == max }.keys.first
  end

end
