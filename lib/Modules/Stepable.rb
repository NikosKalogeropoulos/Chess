module Stepable
  def moves
    row,col = @pos
    moves = move_diffs.map do |(dx, dy)|
      [row + dx, col + dy]
    end.select do |new_row, new_col|
      [new_row, new_col].all? do |coord|
        coord.between?(0,7)
      end
    end
    moves
  end

end
