require_relative 'slideable'
require_relative 'steppable'
require_relative 'pawnable'

class Piece
  attr_accessor :pos, :moved
  attr_reader :board, :color

  def initialize(board, pos, color, moved = false)
    @board = board
    @pos = pos
    @color = color
    @empty = false
    @moved = moved
  end

  def empty?
    @empty
  end

  def move!(end_pos)
    #debugger
    #available_moves = possible_moves
    board[end_pos] = self.class.new(board, end_pos, color, moved)
    board[@pos] = EmptyPiece.new
    board.render(end_pos)
  end

  def move(end_pos)
    piece = board[end_pos]
    board[end_pos] = self.class.new(board, end_pos, color, moved)
    board[@pos] = piece
    board.render(end_pos)
  end

  def to_s
  end

  def possible_moves
    []
  end

  def escape_check(start_pos)
    piece = board[start_pos]
    board[start_pos] = self.class.new(board, start_pos, color, moved)
    board[@pos] = piece
    puts "Can't move into check!"
    board.render(start_pos)

  end

end

class Rook < Piece
  include Slideable
  MOVE_VECTORS = [[-1,0], [1,0], [0,1], [0,-1]]

  attr_accessor :moves

  def initialize(board, pos, color, moved = false)
    super
  end

  def to_s
    " ♜  ".colorize(color.intern)
  end

  def move!(ending_pos)
    available_moves = possible_moves
    super
  end

  def move(end_pos)
    super
  end


  def possible_moves
    get_moves(board, pos, MOVE_VECTORS, color)
  end

end

class Bishop < Piece
  include Slideable
  MOVE_VECTORS = [[-1,-1], [-1,1], [1,1], [1,-1]]

  attr_accessor :moves

  def initialize(board, pos, color, moved = false)
    super
  end

  def to_s
    " ♝  ".colorize(color.intern)
  end

  def move!(end_pos)
    super
  end

  def move(end_pos)
    super
  end

  def possible_moves
    get_moves(board, pos, MOVE_VECTORS, color)
  end

end

class Queen < Piece
  include Slideable
  MOVE_VECTORS = [[-1,0], [1,0], [0,1], [0,-1],
                  [-1,-1], [-1,1], [1,1], [1,-1]]

  attr_accessor :moves

  def initialize(board, pos, color, moved = false)
    super
  end

  def to_s
    " ♛  ".colorize(color.intern)
  end

  def move!(ending_pos)
    available_moves = possible_moves
    super
  end

  def move(end_pos)
    super
  end

  def possible_moves
    get_moves(board, pos, MOVE_VECTORS, color)
  end

end

class King < Piece
  include Steppable
  MOVE_VECTORS = [[-1,0], [1,0], [0,1], [0,-1],
                  [-1,-1], [-1,1], [1,1], [1,-1]]

  attr_accessor :moves

  def initialize(board, pos, color, moved = false)
    super
  end

  def to_s
    " ♚  ".colorize(color.intern)
  end

  def move!(ending_pos)
    available_moves = possible_moves
    super
  end

  def move(end_pos)
    super
  end

  def possible_moves
    get_moves(board, pos, MOVE_VECTORS, color)
  end

end

class Knight < Piece
  include Steppable
  MOVE_VECTORS = [[2,1], [2,-1], [-2,-1], [-2,1],
                  [1,2], [1,-2], [-1,-2], [-1,2]]

  attr_accessor :moves


  def initialize(board, pos, color, moved = false)
    super
  end

  def to_s
    " ♞  ".colorize(color.intern)
  end

  def move!(ending_pos)
    super
    available_moves = possible_moves
  end

  def move(end_pos)
    super
  end

  def possible_moves
    get_moves(board, pos, MOVE_VECTORS, color)
  end

end


class Pawn < Piece
  include Pawnable
  attr_accessor :moves, :moved

  def initialize(board, pos, color, moved = false)
    super
  end

  def move_vectors
    return color == "red" ? [[-1, 0]] : [[1, 0]]
  end

  def initial_vectors
    return color == "red" ? [[-2, 0], [-1, 0]] : [[2, 0], [1, 0]]
  end

  def to_s
    " ♟  ".colorize(color.intern)
  end

  def move!(ending_pos)
    @moved = true
    super
  end

  def move(end_pos)
    super
  end

  def possible_moves
    if !moved
      get_moves(board, pos, initial_vectors) + attack_moves(board, pos, color)
    else
      get_moves(board, pos, move_vectors) + attack_moves(board, pos, color)
    end

  end

end
