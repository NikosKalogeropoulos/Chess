require_relative "./Board"
require_relative "./Cursor"

class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    row = 0
    while row < 8
      col = 0
      while col < 8
        pos = [row,col]
        if pos == @cursor.cursor_pos
          color = nil
          @cursor.selected ? color = :green : color = :red
          print @board[pos].to_s.colorize(color)
        else
          print @board[pos].to_s.colorize(@board[pos].color)
        end
        col +=1
      end
      puts
      row +=1
    end
  end

  def play
    while true
      system("clear")
      render
      @cursor.get_input
    end
  end

end


if __FILE__ == $PROGRAM_NAME
  b = Board.new
  b.move_piece([1,2], [2,2])
  b.move_piece([2,2], [3,2])
  b.move_piece([3,2], [4,2])
  b.move_piece([4,2], [5,2])
  b.move_piece([5,2], [6,3])
  p b.checkmate?(Piece::COLOR_WHITE)
end
