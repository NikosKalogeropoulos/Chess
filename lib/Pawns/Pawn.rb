require_relative "Piece"

class Pawn < Piece
  def symbol
    PIECE_SYMBOLS[:PAWN]
end

  def moves
    row, col = @pos
    step_pos = [[row + forward_dir, col]]
    double_step_pos = [[row + 2 * forward_dir, col]]
    if enemy_piece?(step_pos.flatten)
      return side_attacks
    elsif enemy_piece?(double_step_pos.flatten)
      return side_attacks + step_pos
    end
    side_attacks + forward_steps + step_pos
  end

  private
  def at_start_row?
    row, col = @pos
    if @color == Piece::COLOR_BLACK
      return row == 1
    end
    if @color == Piece::COLOR_WHITE
      return row == 6
    end
  end

  def forward_dir
    @color == Piece::COLOR_BLACK ? 1 : -1
  end

  def forward_steps
    row, col = @pos
    if self.at_start_row?
      return [[row + (forward_dir * 2), col]]
    end
    []
  end

  def side_attacks
    row, col = @pos
    if enemy_piece?([row + forward_dir, col + 1]) || enemy_piece?([row + forward_dir, col - 1])
      return [[row + forward_dir, col + 1], [row + forward_dir, col - 1]]
    end
    []
  end
end
