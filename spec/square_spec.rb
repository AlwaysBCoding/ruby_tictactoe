require 'square'

describe 'Square' do
  
  it "is initialized without an 'X' or 'O'" do
   square = Square.new(0,0)
   square.text_value.should be_nil
  end
  
  it "is initialized with the correct values" do
    square = Square.new(1,1,3)
    square.x_value.should == 1
    square.y_value.should == 1
    square.diag_value.should == 3
    square.text_value.should be_nil
  end
  
  it "can change it's text_value to 'X' or 'O'" do
   square = Square.new(0,0)
   square.change_text_value("X")
   square.text_value.should == "X"
  end
  
end