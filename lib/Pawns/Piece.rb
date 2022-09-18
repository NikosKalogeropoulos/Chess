class Piece
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
    debugger
    moves.select do |new_row, new_col|
      @board[new_row][new_col] == nil || @board[new_row][new_col].color != @board[current_row][current_col].color
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

end
