class Piece

  attr_reader :display_symbol

  def initialize(color,pos)
    @color = color
    @symbol = symbol
    @display_symbol = :P
    @current_pos = pos
  end

  def to_s
    @symbol.to_s
  end

  def empty?
    false
  end

  def symbol
    self.class.to_sym
  end

  def valid_moves
    on_board = self.moves.select do |move|
      move.all? { |coord| (0..7).include? coord }
    end
    board[move].empty?
  end

  def move_into_check(to_pos)
  end
end

module SlidingPiece
  DIAG = [[1,1],[-1,-1],[1,-1],[-1,1]]
  HOR = [[0,1],[0,-1],[1,0],[1,0]]

  def moves
    moves = []
    i = 1
    until i > 8
      moves << @current_pos[0] + i * 
    end
  end
end

module SteppingPiece

  def moves
    poss_moves = []
    self.move_diffs.each do |diff|
      poss_moves << [@current_pos[0] + diff[0], @current_pos[1] + diff[1]]
    end
    poss_moves
  end

  private

  def move_diffs
  end
end
