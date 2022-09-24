require_relative "Piece"
require_relative "../Modules/Stepable"

class King < Piece
  include Stepable

  def symbol
    PIECE_SYMBOLS[:KING]
  end

  protected

  def move_diffs
    deltas = [
      [-1, -1],
      [-1, 0],
      [-1, 1],
      [0, -1],
      [0, 1],
      [1, -1],
      [1, 0],
      [1, 1]
    ]
  end
end
