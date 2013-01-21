require 'game'

describe 'Game' do

  let(:game) { Game.new("H", "C") }

  it 'begins a game with two players and a board' do
    game.player1.should_not be_nil
    game.player2.should_not be_nil
    game.board.should_not be_nil
  end

  describe '#over?' do

    it 'ends the game at a horizontal win' do
      game.player2.make_move(game.board.square1)
      game.player2.make_move(game.board.square2)
      game.player2.make_move(game.board.square3)
      game.over?.should be_true
    end

    it 'ends the game at a vertical win' do
      game.player2.make_move(game.board.square3)
      game.player2.make_move(game.board.square6)
      game.player2.make_move(game.board.square9)
      game.over?.should be_true
    end

    it 'ends the game at a diagonal win' do
      game.player2.make_move(game.board.square3)
      game.player2.make_move(game.board.square5)
      game.player2.make_move(game.board.square7)
      game.over?.should be_true
    end

    it 'ends the game at a draw' do
      9.times do |i|
        game.player1.make_move(game.board.send("square#{i+1}".to_sym))
      end
      game.over?.should be_true
    end

    it "doesn't end the game prematurely" do
      2.times do |i|
        game.player1.make_move(game.board.send("square#{i+1}".to_sym))
      end
      game.over?.should be_false
    end

  end # #game_over?

  describe "#switch_turn(turn)" do

    it 'switches the turn after a move' do

    game.turn.should == :player1
    game.make_move(:player1, game.square5)
    game.turn.should == :player2

  end

  end # #switch_turn(turn)

end
