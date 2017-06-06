require_relative 'piece'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
    make_starting_grid
  end

  def make_starting_grid
    (0..7).each do |row|
      (0..7).each do |col|
        if [0,1,6,7].include?(row)
          @grid[row][col] = Piece.new
        else
          @grid[row][col] = nil
        end
      end
    end
  end

  def [] pos
    x, y = pos
    @grid[x][y]
  end

  def []= pos, piece
    x, y = pos
    @grid[x][y] = piece
  end

  def dup
  end

  def move_piece(from_pos, to_pos)
    raise Exception.new if self[from_pos].nil?
    raise Exception.new unless self[to_pos].nil?
    piece = self[from_pos]
    self[from_pos], self[to_pos] = nil, piece
  rescue Exception
    puts "Invalid move."
  end

  def in_bounds?(pos)
    pos.all? { |coord| (0..7).include?(coord) }
  end

  # def move_piece!(from_pos, to_pos)
  # end

  def checkmate?
  end

  def find_king(color)
  end
end
