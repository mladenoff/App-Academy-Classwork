require_relative 'piece'

class Knight
  include SteppingPiece

  protected

  def move_diffs
    [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]
  end
end
