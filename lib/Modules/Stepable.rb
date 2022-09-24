module Stepable
  def moves
    row, col = @pos
    moves =
      move_diffs
        .map { |(dx, dy)| [row + dx, col + dy] }
        .select do |new_row, new_col|
          [new_row, new_col].all? { |coord| coord.between?(0, 7) }
        end
    moves
  end
end
