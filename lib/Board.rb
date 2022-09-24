require_relative "./Pawns/Piece.rb"
require_relative "./Pawns/Knight.rb"
require_relative "./Pawns/King.rb"
require_relative "./Pawns/Queen.rb"
require_relative "./Pawns/Rook.rb"
require_relative "./Pawns/Bishop.rb"
require_relative "./Pawns/NullPiece.rb"
require_relative "./Pawns/Pawn.rb"
require_relative "./Errors/InvalidMove.rb"
require_relative "./Display"
require "colorize"
require "byebug"

class Board
  attr_accessor :rows
  def initialize
    @null_piece = NullPiece.instance
    @rows = init_board
  end

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @rows[row][col] = val
  end

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    self[end_pos] = @null_piece
    self[end_pos] = self[start_pos]
    self[start_pos] = @null_piece
    self[end_pos].pos = end_pos
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].is_a?(NullPiece) || !self[start_pos].is_a?(Piece)
      raise ArgumentError.new("start_pos element doesn't have a valid Piece")
    end
    piece = self[start_pos]
    unless piece.valid_moves.include?(end_pos)
      raise InvalidMove.new(
              "Invalid move for #{piece.to_s}\nStarting position: row #{start_pos[0]} col #{start_pos[1]}\nEnd position: row #{end_pos[0]} col #{end_pos[1]}\nValid positions: #{piece.valid_moves}"
            )
    end
    self[end_pos] = @null_piece
    self[end_pos] = self[start_pos]
    self[start_pos] = @null_piece
    self[end_pos].pos = end_pos
  end

  def in_check?(color)
    # Find the position of the king with the specific color on the board
    king_piece = get_king_piece(color)

    # See if any of the opposing pieces can move to that position
    @rows.each_with_index do |cols, idx|
      cols.each_with_index do |element, ydx|
        # check only enemy pawns
        if king_piece.enemy_piece?([idx, ydx])
          return true if element.filter_moves.include?(king_piece.pos)
        end
      end
    end
    false
  end

  def checkmate?(color)
    return false unless in_check?(color)
    have_moves_flag = false
    @rows.each do |col|
      col.each do |piece|
        if piece.color == color
          have_moves_flag = true unless piece.valid_moves.empty?
        end
      end
      break if have_moves_flag
    end
    !have_moves_flag
  end

  def dup
    board = Board.new
    board.rows = @rows.dup.map(&:dup)
    i = 0
    while i < 8
      j = 0
      while j < 8
        if @rows[i][j].is_a?(NullPiece)
          board[[i, j]] = NullPiece.instance
        else
          piece = @rows[i][j]
          assign_duped_piece_to_board(piece, board)
        end
        j += 1
      end
      i += 1
    end
    board
  end

  private

  def assign_duped_piece_to_board(piece, board)
    duped_piece_color = piece.color.dup
    duped_piece_pos = piece.pos.dup
    duped_piece = piece.dup
    duped_piece.color = duped_piece_color
    duped_piece.pos = duped_piece_pos
    duped_piece.board = board
    board[duped_piece.pos] = duped_piece
  end

  def get_king_piece(color)
    king_piece = nil
    @rows.each do |cols|
      cols.each do |element|
        if element.symbol == PIECE_SYMBOLS[:KING] && element.color == color
          king_piece = element
          break
        end
      end
      break if king_piece != nil
    end
    king_piece
  end

  def init_board
    i = 0
    board = Array.new(8) { Array.new(8) { @null_piece } }
    while i < 8
      j = 0
      while j < 8
        if i < 2
          if i == 0
            if j == 0 || j == 7
              board[i][j] = Rook.new(Piece::COLOR_BLACK, self, [i, j])
            elsif j == 1 || j == 6
              board[i][j] = Knight.new(Piece::COLOR_BLACK, self, [i, j])
            elsif j == 2 || j == 5
              board[i][j] = Bishop.new(Piece::COLOR_BLACK, self, [i, j])
            elsif j == 3
              board[i][j] = Queen.new(Piece::COLOR_BLACK, self, [i, j])
            else
              board[i][j] = King.new(Piece::COLOR_BLACK, self, [i, j])
            end
          else
            board[i][j] = Pawn.new(Piece::COLOR_BLACK, self, [i, j])
          end
        end
        if i > 5
          if i == 6
            board[i][j] = Pawn.new(Piece::COLOR_WHITE, self, [i, j])
          elsif i == 7
            if j == 0 || j == 7
              board[i][j] = Rook.new(Piece::COLOR_WHITE, self, [i, j])
            elsif j == 1 || j == 6
              board[i][j] = Knight.new(Piece::COLOR_WHITE, self, [i, j])
            elsif j == 2 || j == 5
              board[i][j] = Bishop.new(Piece::COLOR_WHITE, self, [i, j])
            elsif j == 3
              board[i][j] = Queen.new(Piece::COLOR_WHITE, self, [i, j])
            else
              board[i][j] = King.new(Piece::COLOR_WHITE, self, [i, j])
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
  b_dup = b.dup
  b.move_piece([1, 2], [2, 2])
  b.move_piece([2, 2], [3, 2])
  b.move_piece([3, 2], [4, 2])
  b.move_piece([4, 2], [5, 2])
  b.move_piece([5, 2], [6, 3])

  p b.checkmate?(Piece::COLOR_BLACK)
end
