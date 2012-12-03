class Square
  attr_accessor :x_value, :y_value, :text_value
  
  def initialize(x,y,text_value=nil)
    @x_value = x
    @y_value = y
    @text_value = text_value
  end
    
  def change_text_value(val)
    @text_value = val
  end  

end