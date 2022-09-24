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


  def empty?

  end

  def moves

  end

  def filter_moves
    moves.select {|pos| @board[pos].is_a?(NullPiece) || enemy_piece?(pos)}
  end

  def valid_moves
    return [] if filter_moves.empty?
    filter_moves.select {|pos| !move_into_check?(pos)}
  end

  def symbol
  end

  def enemy_piece?(pos)
    @board[pos].is_a?(Piece) && !@board[pos].is_a?(NullPiece) && @board[pos].color != self.color
  end

  def inspect
    to_s + "#{@color}"
  end
  private

  def move_into_check?(end_pos)
    duplicate_board = @board.dup
    duplicate_board.move_piece!(@pos, end_pos)
    duplicate_board.in_check?(@color)
  end


end
