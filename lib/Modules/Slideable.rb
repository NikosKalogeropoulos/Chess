require_relative "../Pawns/Piece"
module Slideable

  def moves
    row, col = @pos
    moves_array = []
    move_dirs.each do |dx, dy|
      moves_array += grow_unblocked_moves_in_dir(row, col, dx, dy);
    end
    moves_array
  end

  private
  def grow_unblocked_moves_in_dir(row, col, dx, dy)
    new_row = row + dx
    new_col = col + dy
    # if new_row, new_col doesn't exist return without adding the move
    return [] unless new_row.between?(0, 7) && new_col.between?(0,7)
    # if new_row, new_col friendly piece return without adding the move (we check for this in valid_moves as well)
    new_board_position_element = @board[[new_row, new_col]]
    return [] if new_board_position_element.is_a?(Piece) && new_board_position_element.color == self.color
    # if new_row, new_col enemy piece return and add the move
    return [[new_row, new_col]] if new_board_position_element.is_a?(Piece) && new_board_position_element.color != self.color
    [[new_row, new_col]] + grow_unblocked_moves_in_dir(new_row, new_col, dx, dy)
  end
end
