require 'game'

describe 'Game' do
  
  let(:game) { Game.new("C") }
  
  it 'begins a game with a human, computer, and board' do
    game.computer.should_not be_nil
    game.human.should_not be_nil
    game.board.should_not be_nil
  end
  
  describe '#over?' do
    
    it 'ends the game at a horizontal win' do
      game.computer.make_move(game.board.square1)
      game.computer.make_move(game.board.square2)
      game.computer.make_move(game.board.square3)
      game.over?.should be_true
    end
    
    it 'ends the game at a vertical win' do
      game.computer.make_move(game.board.square3)
      game.computer.make_move(game.board.square6)
      game.computer.make_move(game.board.square9)
      game.over?.should be_true
    end
    
    it 'ends the game at a diagonal win' do
      game.computer.make_move(game.board.square3)
      game.computer.make_move(game.board.square5)
      game.computer.make_move(game.board.square7)
      game.over?.should be_true
    end
    
    it 'ends the game at a draw' do
      9.times do |i|
        game.human.make_move(game.board.send("square#{i+1}".to_sym))
      end
      game.over?.should be_true 
    end
    
    it "doesn't end the game prematurely" do
      8.times do |i|
        game.human.make_move(game.board.send("square#{i+1}".to_sym))
      end
      game.over?.should be_false
    end
    
  end # #game_over?
  
end
