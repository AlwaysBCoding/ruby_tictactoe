class Human

  def has_square?(sq)
    return true if sq.text_value == "X"
  end

  def make_move(sq)
    sq.text_value = "X"
    return sq
  end

	def make_moves(*args)
		args.each do |sq|
			sq.text_value = "X"
		end
	end

end

