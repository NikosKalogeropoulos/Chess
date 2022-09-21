class Piece
  COLOR_BLACK = :black
  COLOR_WHITE = :white
  NO_COLOR = :cyan
  attr_accessor :color, :pos, :board
  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
    symbol
  end

  def update_pos

  end

  def empty?

  end

  def moves

  end

  def valid_moves
    current_row, current_col = @pos
    moves.select do |new_row, new_col|
      @board[new_row][new_col].is_a?(NullPiece)  || enemy_piece?([new_row, new_col])
    end
  end

  def pos=(val)
    @pos = val
  end

  def symbol

  end

  def enemy_piece?(pos)
    row,col = pos
    board[row][col].is_a?(Piece) && !@board[row][col].is_a?(NullPiece) && @board[row][col].color != self.color
  end

  private

  def move_into_check?(end_pos)

  end


end
