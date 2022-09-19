require_relative "Board"

class Display
  def initialize(board)
    @board = board
  end

  def render
    @board.rows.each do |col|
      col.each do |piece|
        print piece.to_s.colorize(:black) if piece.color == Piece::COLOR_BLACK
        print piece.to_s.colorize(:white) if piece.color == Piece::COLOR_WHITE
        print piece if piece.is_a?(NullPiece)
      end
      puts
    end
  end
end


if __FILE__ == $PROGRAM_NAME
  b = Board.new
  b.move_piece([1,1], [2,1])
  b.move_piece([2,1], [3,1])
  b.move_piece([3,1], [4,1])
  b.move_piece([4,1], [5,1])
  b.move_piece([5,1], [6,2])
  b.move_piece([0,1], [2,2])
  d = Display.new(b)
  d.render
end
