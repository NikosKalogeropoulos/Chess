require_relative "./Board"
require_relative "./Cursor"

class Display
  attr_accessor :cursor
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
          if @cursor.selected
            color = @board[pos].color
            background_color = :magenta
          else
            color = @board[pos].color
            background_color = :black
          end
          print @board[pos].to_s.colorize(:background => background_color, :color => color)
        elsif @board[pos].is_a?(Piece) && (row + col).even?
          print @board[pos].to_s.colorize(:background => :light_white, :color => @board[pos].color)
        else

          print @board[pos].to_s.colorize(:background => :light_black, :color => @board[pos].color)
        end
        col +=1
      end
      puts
      row +=1
    end
    puts
    puts "Keyboard arrows to move cursor"
    puts "enter to select a piece/move piece"
    puts  "ctrl + c to exit"
  end
end


if __FILE__ == $PROGRAM_NAME
  b = Board.new
  d = Display.new(b)
  d.render
  b.move_piece([1,2], [2,2])
  d.render
  b.move_piece([2,2], [3,2])
  b.move_piece([3,2], [4,2])
  b.move_piece([4,2], [5,2])
  b.move_piece([5,2], [6,3])
  p b.checkmate?(Piece::COLOR_WHITE)
end
