require 'colorize'
require_relative 'cursor'

class Display

  attr_reader :cursor, :board

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def render
    pos = @cursor.cursor_pos
    display_hash = { :p => 'P', nil => '~' }
    no_color_grid = @board.grid.map do |row|
      row.map { |piece| (piece.is_a?(Piece) ? display_hash[piece.display_symbol] : '~').colorize( :background => :cyan ) }
    end
    if @cursor.selected
      no_color_grid[pos[0]][pos[1]] = no_color_grid[pos[0]][pos[1]].blue.on_red.blink
    else
      no_color_grid[pos[0]][pos[1]] = no_color_grid[pos[0]][pos[1]].colorize(:red)
    end
    no_color_grid.each do |row|
      puts row.join(' '.colorize( :background => :cyan ))
    end
  end


end
