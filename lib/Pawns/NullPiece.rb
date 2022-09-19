require_relative "Piece"
require "singleton"

class NullPiece < Piece
  include Singleton
  def initialize
  end
  def color
    Piece::NO_COLOR
  end
  def symbol
    " "
  end

  def moves
    []
  end
end
