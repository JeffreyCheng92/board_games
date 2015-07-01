load 'tile.rb'
require 'byebug'

class Board
  SURROUNDINGS = [[-1,-1], [-1, 0], [-1, 1], [0, -1],
                  [0, 1], [1, -1], [1, 0], [1, 1] ]

  attr_accessor :grid

  def initialize
    @grid = Array.new(9) { Array.new(9) {Tile.new} }
    # @grid = Array.new(9) { Array.new(9) {Tile.new(self, pos)} }
    plant_bombs
    assign_values
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def revealer(pos)
    queue = [pos]

    until queue.empty?
      current_pos = queue.shift

      if self[current_pos].value > 0
        self[current_pos].revealed = true
      elsif self[current_pos].value == 0
        # see if you can make this a helper method
        revealer_helper(queue, pos)
      else
        continue
      end
    end
  end

  def render
    system("clear")
    @grid.each do |row|
      # we may need to change this later -Jeff
      row.each_with_index do |tile, idx|
        render_help(tile)
        puts if (idx + 1) % 9 == 0
      end
      # we need to be able to change this 9 later to take in a harder game
    end
  end

  def won?
    # this needs to be grid and not 'board.select'
    safe_pos = []
    grid.each_with_index do |row, i|
      row.each_index do |j|
        safe_pos << [i, j] unless self[[i, j]].bombed?
      end
    end
    return true if safe_pos.all? { |pos| self[pos].revealed }
    return false
  end

  private

  def assign_values
    grid.each_with_index do |row, i|
      row.each_index do |idx|
        get_value([i, idx])
      end
    end
  end

  def bomb_check?(loc)
    self[loc].bombed?
  end

  def render_help(tile)
    # make this a tile method
    if tile.flagged?
      print " F "
    elsif tile.bombed?
      print tile.revealed ? " B " : " * "
    elsif tile.revealed && tile.value == 0
      print " _ "
    elsif !tile.revealed
      print " * "
    else
      print " #{tile.value} "
    end
  end

  def invalid_pos?(pos)
    pos[0] < 0 || pos[0] > 8 || pos[1] < 0 || pos[1] > 8
  end

  def plant_bombs
    10.times do
      bomb_pos = [rand(9), rand(9)]
      bomb_pos = [rand(9), rand(9)] until !bomb_check?(bomb_pos)
      # the Tile should bomb its position, not the board
      self[bomb_pos].bombed = true
      # self[bomb_pos].revealed = true
    end
  end

  def get_value(pos)
    # move to Tile class
    unless self[pos].bombed?
      self[pos].value = value_helper(pos)
    end
  end

  def value_helper(pos)
    counter = 0
    # could make this a helper method
    SURROUNDINGS.each do |el|
      new_pos = [el[0] + pos[0], el[1] + pos[1]]
      # we'll want to refactor this later
      next if invalid_pos?(new_pos)
      counter += 1 if self[new_pos].bombed?
    end
    counter
  end

  def revealer_helper(queue, pos)
    SURROUNDINGS.each do |el|
      self[pos].revealed = true

      new_pos = [el[0] + pos[0], el[1] + pos[1]]
      next if invalid_pos?(new_pos)
      next if self[new_pos].revealed
      queue << new_pos
    end
    queue
  end
end
