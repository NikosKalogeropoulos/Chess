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
          print @board[pos].to_s.colorize(:red) unless @cursor.selected
          print @board[pos].to_s.colorize(:green) if @cursor.selected
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
  b.move_piece([1,1], [2,1])
  b.move_piece([2,1], [3,1])
  b.move_piece([3,1], [4,1])
  b.move_piece([4,1], [5,1])
  b.move_piece([5,1], [6,2])
  b.move_piece([0,1], [2,2])
  d = Display.new(b)
  d.play
end
