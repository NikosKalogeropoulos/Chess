require_relative "./Pawns/Piece.rb"
require_relative "./Pawns/Knight.rb"
require_relative "./Pawns/King.rb"
require_relative "./Pawns/Queen.rb"
require_relative "./Pawns/Rook.rb"
require_relative "./Pawns/Bishop.rb"
require_relative "./Pawns/NullPiece.rb"
require_relative "./Pawns/Pawn.rb"
require_relative "./Errors/InvalidMove.rb"
require "byebug"

class Board
  def initialize
    @null_piece = NullPiece.instance
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
    raise ArgumentError.new("start_pos element doesn't have a valid Piece") if self[start_pos].is_a?(NullPiece) || !self[start_pos].is_a?(Piece)
    piece = self[start_pos]
    raise InvalidMove.new("Invalid move for #{piece.to_s}\nStarting position: row #{start_pos[0]} col #{start_pos[1]}\nEnd position: row #{end_pos[0]} col #{end_pos[1]}\nValid positions: #{piece.valid_moves}") unless piece.valid_moves.include?(end_pos)
    self[end_pos].pos = @null_piece if self[end_pos].is_a?(Piece)
    self[end_pos] = self[start_pos]
    self[start_pos] = @null_piece
    self[end_pos].pos = end_pos
  end

  def render
    @rows.each do |col|
      col.each do |piece|
        print piece
      end
      puts
    end
  end

  private
  def init_board
    i = 0
    board = Array.new(8) {Array.new(8) {@null_piece} }
    while i < 8
      j = 0
      while j < 8
        if i < 2
          if i == 0
            if j == 0 || j == 7
              board[i][j] = Rook.new(Piece::COLOR_BLACK, board, [i,j])
            elsif j == 1 || j == 6
              board[i][j] = Knight.new(Piece::COLOR_BLACK, board, [i,j])
            elsif j == 2 || j == 5
              board[i][j] = Bishop.new(Piece::COLOR_BLACK, board, [i,j])
            elsif j == 3
              board[i][j] = Queen.new(Piece::COLOR_BLACK, board, [i,j])
            else
              board[i][j] = King.new(Piece::COLOR_BLACK, board, [i,j])
            end
          else
            board[i][j] = Pawn.new(Piece::COLOR_BLACK, board, [i,j])
          end
        end
      if i > 5
        if i == 6
          board[i][j] = Pawn.new(Piece::COLOR_WHITE, board, [i,j])
        elsif i == 7
          if j == 0 || j == 7
              board[i][j] = Rook.new(Piece::COLOR_BLACK, board, [i,j])
            elsif j == 1 || j == 6
              board[i][j] = Knight.new(Piece::COLOR_BLACK, board, [i,j])
            elsif j == 2 || j == 5
              board[i][j] = Bishop.new(Piece::COLOR_BLACK, board, [i,j])
            elsif j == 3
              board[i][j] = Queen.new(Piece::COLOR_BLACK, board, [i,j])
            else
              board[i][j] = King.new(Piece::COLOR_BLACK, board, [i,j])
            end
        end
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
  b.move_piece([1,1], [2,1])
  b.move_piece([2,1], [3,1])
  b.move_piece([3,1], [4,1])
  b.move_piece([4,1], [5,1])
  b.move_piece([0,1], [2,2])
  b.move_piece([3,3], [5,1])
  b.render
end
