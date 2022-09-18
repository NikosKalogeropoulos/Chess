require_relative "Piece"
require_relative "../Modules/Slideable"

class Rook < Piece
  include Slideable

  def symbol
    "R"
  end

  private
  def move_dirs
    dirs = [
      [1,0],
      [-1, 0],
      [0, 1],
      [0, -1]
    ]
  end
end
