module Pawnable

  def get_moves(board, current_pos, vectors)
    positions = []

    vectors.each do |vector|
      curr_pos = current_pos
      curr_pos = [ curr_pos[0] + vector[0], curr_pos[1] + vector[1] ]

      unless !inside_boundaries?(curr_pos) || invalid_pos?(board, curr_pos)
        positions << curr_pos
      end

    end

    positions
  end

  def attack_moves(board, current_pos, color)
    positions = []
    if color == 'red'
      top_attack_helper(board, current_pos, color, positions)
    else
      bot_attack_helper(board, current_pos, "blue", positions)
    end

    positions
  end

  private

  def top_attack_helper(board, pos, color, pos_array)
    top_left = [pos[0] - 1, pos[1] - 1]
    top_right = [pos[0] - 1, pos[1] + 1]

    if board[top_left]
      if !board[top_left].empty? && board[top_left].color != color
        pos_array << top_left
      end
    end

    if board[top_right]
      if !board[top_right].empty? && board[top_right].color != color
        pos_array << top_right
      end
    end
  end

  def bot_attack_helper(board, pos, color, pos_array)
    bot_left = [pos[0] + 1, pos[1] - 1]
    bot_right = [pos[0] + 1, pos[1] + 1]

    if board[bot_left]
      if !board[bot_left].empty? && board[bot_left].color != color
        pos_array << bot_left
      end
    end
    if board[bot_right]
      if !board[bot_right].empty? && board[bot_right].color != color
        pos_array << bot_right
      end
    end
  end

  def invalid_pos?(board, pos)
    !board[pos].empty?
  end

  def inside_boundaries?(pos)
    pos.all? { |el| el.between?(0, 7) }
  end

end
