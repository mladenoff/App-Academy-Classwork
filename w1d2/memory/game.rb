require_relative "board"
require_relative "card"
require_relative "human_player"
require_relative "ai_player"

class Game
  attr_reader :board
  def initialize
    @board = Board.new
    @previous_guess = nil
    @player1 = AIPlayer.new("Bob")
  end

  def board_pop
    @board.populate
  end

  def make_guess(pos)
    if @previous_guess
      @current_guess = pos
      @player1.hash_maker(pos, @board[@current_guess].reveal)
    else
      @previous_guess = pos
      @board[@previous_guess].reveal
    end
  end

  def check_guess?
    @board[@current_guess] == @board[@previous_guess]
  end

  def play
    board_pop
    @board.render
    until @board.won?
      make_guess(@player1.prompt)
      @board.render
      make_guess(@player1.prompt)
      @board.render
      unless check_guess?
        @board[@current_guess].hide
        @board[@previous_guess].hide
      end
      @current_guess = nil
      @previous_guess = nil
    end
    puts "Winner winner chicken dinner!"
  end



end
