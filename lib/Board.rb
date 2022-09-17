require_relative "./Pawns/Piece.rb"
require_relative "./Pawns/NullPiece.rb"
require_relative "./Errors/OutOfBoundsError.rb"
require "byebug"

class Board
  def initialize
    @rows = init_board
  end

  def [](pos)
    row,col = pos
    @rows[row][col]
  end

  def []=(pos, val)
    row,col = pos
    @rows[row][col] = val

  end

  def move_piece(start_pos, end_pos)
    raise ArgumentError.new("start_pos element doesn't have a Piece") unless self[start_pos].is_a?(Piece)
    e_row,e_col = end_pos
    raise OutOfBoundsError.new("cannot move to end_pos") if e_row < 0 || e_row > 7 || e_col < 0 || e_col > 7
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end

  private
  def init_board
    i = 0
    board = Array.new(8) {Array.new(8, nil)}
    debugger
    while i < 8
      j = 0
      while j < 8
        if i < 2 || i > 5
          board[i][j] = Piece.new("yo")
        end
        j += 1
      end
      i += 1
    end
    board
  end

end


if __FILE__ == $PROGRAM_NAME
  b = Board.new
  b.move_piece([0,0], [3,0])
  b.move_piece([0,1], [-1,0])
  p b
end
