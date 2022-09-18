require_relative "Piece"
require "singleton"

class NullPiece < Piece
  include Singleton
  attr_reader :color

  def symbol
    " "
  end
end
