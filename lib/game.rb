require_relative './human.rb'
require_relative './computer.rb'

class Game
  attr_accessor :human, :computer, :board
  
  def initialize
    @human = Human.new
    @computer = Computer.new
    @board = Board.new
  end
end