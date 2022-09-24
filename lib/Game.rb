require_relative "./Pawns/Piece.rb"
require_relative "./Board.rb"
require_relative "./Display.rb"
require_relative "./HumanPlayer.rb"
require "byebug"
class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player_1 = HumanPlayer.new(Piece::COLOR_WHITE, @display)
    @player_2 = HumanPlayer.new(Piece::COLOR_BLACK, @display)
    @current_player = @player_1
  end

  def play
    while true
      begin
        @current_player.make_move(@board)
      rescue StandardError => e
        system("clear")
        puts "#{@current_player.color} please enter correct move: #{e.message}"
        sleep(5)
        retry
      end
      next_player
      break if @board.checkmate?(@current_player.color)
    end
  end

  private

  def next_player
    @current_player == @player_1 ?
      @current_player = @player_2 :
      @current_player = @player_1
  end
end

Game.new.play if __FILE__ == $PROGRAM_NAME
