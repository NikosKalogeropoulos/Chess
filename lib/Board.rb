require_relative "./Pawns/Piece.rb"
require_relative "./Pawns/Knight.rb"
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
    piece = self[start_pos]
    raise InvalidMove.new("Invalid move for #{piece.to_s}\nStarting position: row #{start_pos[0]} col #{start_pos[1]}\nEnd position: row #{end_pos[0]} col #{end_pos[1]}\nValid positions: #{piece.valid_moves}") unless piece.valid_moves.include?(end_pos)
    self[end_pos].pos = nil if self[end_pos].is_a?(Piece)
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
    self[end_pos].pos = end_pos
  end

  private
  def init_board
    i = 0
    board = Array.new(8) {Array.new(8, nil)}
    while i < 8
      j = 0
      while j < 8
        if i < 2 || i > 5
          board[i][j] = Knight.new(:white, board, [i,j])
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
  b.move_piece([0,0], [2,1])
  p b
end
