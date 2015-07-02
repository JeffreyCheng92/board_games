require 'colorize'


class Piece
  attr_accessor :king, :pos
  attr_reader :color, :board

  def initialize(board, pos, color, king = false)
    @board = board
    @pos = pos
    @color = color
    @king = king
  end

  def empty?
    false
  end

  def move

  end

  def perform_slide(target_pos)
    possible_moves.include?(target_pos)
  end

  def perform_jump

  end

  def possible_moves
    moves = []
    vector_add(moves)

    moves.select { |move| move.all? { |coord| coord.between?(0, 7) } }
  end

  def vector_add(array)
    vectors = move_diffs
    vectors.each do |vector|
      new_pos = [pos[0] + vector[0], pos[1] + vector[1]]
      array << new_pos if board[new_pos].empty?
    end
  end

  def to_s
    (king? ? " ☣  " : " ☢  ").colorize(:"#{@color}")
  end

  def move_diffs
    if king?
      [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    elsif color == :white
      [[1, 1], [1, -1]]
    else
      [[-1, 1], [-1, -1]]
    end
  end

  def inspect
    nil
  end

  def king?
    king
  end



end
