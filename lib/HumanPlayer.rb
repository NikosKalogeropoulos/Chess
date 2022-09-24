
require_relative "./Errors/InvalidMove.rb"
require_relative "./Display.rb"
class HumanPlayer
  attr_reader :color
  def initialize(color, display)
    @color = color
    @display = display
  end

  def make_move(board)
    system("clear")
    puts "#{@color} turn"
    render
    starting_position, ending_position = get_input
    raise InvalidMove.new("Can only control #{@color} pawns") if board[starting_position].color != @color
    board.move_piece(starting_position, ending_position)
  end

private

  def render
    @display.render
  end

  def cursor
    @display.cursor
  end

  def get_input
    move = []
    move_counter = 0
    pos = nil
    while true
      pos = cursor.get_input
      system("clear")
      render

      if pos != nil
        move << pos
        move_counter += 1
      end

      break if move_counter == 2
    end
    move
  end
end
