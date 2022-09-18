require_relative "Piece"
require_relative "../Modules/Slideable"

class Bishop < Piece
  include Slideable

  def symbol
    "B"
  end

  private
  def move_dirs
    dirs = [
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1]
    ]
  end
end
