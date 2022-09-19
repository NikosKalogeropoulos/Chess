class Piece
  COLOR_BLACK = :black
  COLOR_WHITE = :white
  NO_COLOR = :none
  attr_reader :color
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
      @board[new_row][new_col].is_a?(NullPiece)  || @board[new_row][new_col].color != @board[current_row][current_col].color
    end
  end

  def pos=(val)
    @pos = val
  end

  def symbol

  end

  private

  def move_into_check?(end_pos)

  end

  def enemy_piece(pos)
    row,col = pos
    if @board[row][col].is_a?(Piece) && !@board[row][col].is_a?(NullPiece) && @board[row][col].color != self.color
      return true
    end
    false
  end
end
