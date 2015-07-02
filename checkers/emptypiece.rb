class EmptyPiece
  attr_reader :king

  def initialize
    @king = false
  end

  def empty?
    true
  end

  def to_s
    "    "
  end

  def color
    ""
  end

  def possible_moves
    []
  end

end
