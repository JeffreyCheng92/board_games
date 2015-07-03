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

  def move!(end_pos)
    if possible_slides.include?(end_pos)
      move_helper(end_pos)
    elsif possible_jumps.include?(end_pos)
      jump_helper(end_pos)
    else
      puts "Invalid move!"
    end
    maybe_promote(end_pos)
  end

  def possible_moves
    possible_jumps + possible_slides
  end

  def perform_slide(target_pos)
    possible_slides.include?(target_pos)
  end

  def perform_jump(target_jump)
    possible_jumps.include?(target_jump)
  end

  def to_s
    (king? ? " ☣ " : " ☢ ").colorize(:"#{@color}")
  end

  # private

  def maybe_promote(pos)
    if color == :white && pos[0] == 7
      board[pos].king = true
    elsif color == :black &&
      pos[0] == 0
      board[pos].king = true
    end
  end

  def possible_jumps
    jumps = []

    vectors = move_diffs
    vectors.each do |vector|

      new_pos = [pos[0] + vector[0], pos[1] + vector[1]]
      next unless board.on_board?(new_pos)
      if !board[new_pos].empty? && board[new_pos].color != color
        jump_pos = [new_pos[0] + vector[0], new_pos[1] + vector[1]]
        jumps << jump_pos if board.on_board?(jump_pos) && board[jump_pos].empty?
      end
    end

    jumps
  end

  def possible_slides
    moves = []
    vector_add(moves)

    moves.select { |move| board.on_board?(move) }
  end

  def vector_add(array)
    vectors = move_diffs
    vectors.each do |vector|
      new_pos = [pos[0] + vector[0], pos[1] + vector[1]]
      next unless board.on_board?(new_pos)
      array << new_pos if board[new_pos].empty?
    end
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

  def jump_helper(end_pos)
    dead_piece_pos = [(pos[0] + end_pos[0]) / 2, (pos[1] + end_pos[1]) / 2]
    board[end_pos] = Piece.new(board, end_pos, color, king)
    board[dead_piece_pos] = EmptyPiece.new
    board[pos] = EmptyPiece.new
  end

  def move_helper(end_pos)
    board[end_pos] = Piece.new(board, end_pos, color, king)
    board[pos] = EmptyPiece.new
  end
end
