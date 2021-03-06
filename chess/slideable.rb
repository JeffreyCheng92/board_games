require 'byebug'

module Slideable

  def get_moves(board, current_pos, vectors, color)
    positions = []

    vectors.each do |vector|
      curr_pos = current_pos
      curr_pos = add_arrays(curr_pos, vector)
      if inside_boundaries?(curr_pos) && invalid_pos?(board, curr_pos)
        positions << curr_pos if check_color(curr_pos, color)
      end
      move_helper(board, curr_pos, vector, positions, color)

    end

    positions
  end

  private

  def add_arrays(arr1, arr2)
    return [ arr1[0] + arr2[0], arr1[1] + arr2[1] ]
  end

  def move_helper(board, curr_pos, vector, positions, color)
    until !inside_boundaries?(curr_pos) || invalid_pos?(board, curr_pos)
      positions << curr_pos unless positions.include?(curr_pos)
      curr_pos = add_arrays(curr_pos, vector)

      if inside_boundaries?(curr_pos) && invalid_pos?(board, curr_pos)
        positions << curr_pos if check_color(curr_pos, color)
      end
    end
  end

  def check_color(pos, color)
    board[pos].color != color
  end

  def invalid_pos?(board, pos)
    !board[pos].empty?
  end

  def inside_boundaries?(pos)
    pos.all? { |el| el.between?(0, 7) }
  end

end
