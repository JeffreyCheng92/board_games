require_relative "tile"

class Board

  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def self.from_file(filename)
    lines = File.readlines(filename)
    lines.map! { |line| line.chomp.split("").map(&:to_i) }
    lines.each_with_index do |line, row|
      line.each_with_index do |el, col|
        lines[row][col] = el != 0 ? Tile.new(el, true) : Tile.new
      end
    end
    Board.new(lines)
  end

  def render
    system("clear")
    grid.each { |line| puts line.map(&:to_s).join("|") }
    nil
  end

  def [](pos)
    x, y = pos
    self.grid[x][y]
  end

  def inspect
    return ""
  end

  def []=(pos, value)
    x, y = pos
    self.grid[x][y] = Tile.new(value)
  end

  def solved?
    rows_check(grid) && cols_check && boxes_check
  end

  private

  def rows_check(grid)
    grid.each do |row|
      tiles = []
      row.each { |tile| tiles << tile.num }
      return false if (1..9).to_a != tiles.sort
    end
    true
  end

  def transpose
    transpose_grid = Array.new(9) { Array.new(9) }
    grid.each_with_index do |row, y|
      row.each_with_index do |el, x|
        transpose_grid[x][y] = el
      end
    end
    transpose_grid
  end

  def cols_check
    transposed = transpose
    rows_check(transposed)
  end

  def find_boxes
    corners = []
    [0, 3, 6].each { |x| [0, 3, 6].each { |y| corners << [x, y] } }
    box_grid = []
    corners.each do |corner|
      box_grid << surroundings(corner)
    end
    box_grid
  end

  def surroundings(pos)
    box_coords = []
    (0..2).each do |x|
      (0..2).each { |y| box_coords << [pos[0] + x, pos[1] + y] }
    end
    box_coords
  end

  def boxes_check
    coords = find_boxes
    rows_check(coords.map { |row| row.map { |coord| self[coord] } })
  end

end
