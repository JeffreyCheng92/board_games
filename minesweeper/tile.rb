class Tile
  attr_accessor :value, :bombed, :flagged, :revealed

  def initialize(board)
    @value = nil
    @bombed = false
    @flagged = false
    @revealed = false
  end

  def bombed?
    @bombed
  end

  def flagged?
    @flagged
  end

end
