require_relative "Piece"
require_relative "../Modules/Slideable"

class Queen < Piece
  include Slideable

  def symbol
    "Q"
  end

  private
  def move_dirs
    dirs = [
      [1,0],
      [-1, 0],
      [0, 1],
      [0, -1],
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1]
    ]
  end
end
