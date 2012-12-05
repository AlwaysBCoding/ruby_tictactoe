require 'square'

describe 'Square' do
  
  it 'is initialized without a text_value' do
   square = Square.new(0,0)
   square.text_value.should be_nil
  end
  
  it "can change it's text_value to 'X' or 'O'" do
   square = Square.new(0,0)
   square.change_text_value("X")
   square.text_value.should == "X"
  end
  
end