require_relative 'board'
require_relative 'display'

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
  end

  def play
    while true
      system("clear")
      @display.render
      @display.cursor.get_input
    end
  end

end

if __FILE__ == $PROGRAM_NAME

  Game.new.play

end
