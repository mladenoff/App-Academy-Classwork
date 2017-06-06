require_relative 'piece'

class King < Piece
  include SteppingPiece

  protected

  def move_diffs
    [[1,1],[-1,-1],[1,-1],[-1,1],[0,1],[0,-1],[1,0],[1,0]]
  end

end
