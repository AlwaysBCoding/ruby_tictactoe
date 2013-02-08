class Square
  attr_accessor :x_value, :y_value, :diag_value, :number, :text_value

  def initialize(x,y,diag=nil,text_value=nil,number=nil)
    @x_value = x
    @y_value = y
    @diag_value = diag
    @text_value = text_value.to_s
		@number = number
	end

  def empty?
    return true if text_value.to_s != "X" && text_value.to_s != "O"
  end

  def change_text_value(val)
    @text_value = val
  end

  def colored_text_value
    return text_value.to_s.green if text_value == "X"
    return text_value.to_s.red if text_value == "O"
    return text_value.to_s.light_yellow
  end

end
