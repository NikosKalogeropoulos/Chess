require_relative "Piece.rb"
require_relative "../Modules/Stepable"

class Knight < Piece
  include Stepable
  def symbol
    PIECE_SYMBOLS[:KNIGHT]
  end

  protected

  def move_diffs
    deltas = [
      [-2, -1],
      [-2, 1],
      [2, -1],
      [2, 1],
      [-1, -2],
      [-1, 2],
      [1, -2],
      [1, 2]
    ]
  end
end
