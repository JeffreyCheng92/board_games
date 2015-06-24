require 'byebug'

class Board

  attr_reader :grid, :previous_move

  def initialize
    @grid = Array.new(6) { Array.new(7) }
    @previous_move = [3,3]
  end

  def render
    system("clear")
    grid.each { |line| puts line.map {|el| el.nil? ? " " : el}.join(" | ") }
    puts (["-"] * 7).join(" - ") + "\n" + (0..6).to_a.join(" | ")
  end

  def drop_disc(col, marker)
    grid.reverse.each_with_index do |row, index|
      if row[col].nil?
        row[col] = marker
        @previous_move = [5-index, col]
        return true
      end
    end
    return false
  end

  def over?
    grid.each_with_index do |line, row|
      line.each_index { |col| return true if four_in_a_row?([row, col]) }
    end
    false
  end

  def winner
    return self[previous_move] if over?
  end

  private

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
  end

  def four_in_a_row?(pos)
    vectors = [[1,0], [0,1], [-1,0], [0,-1], [1,1], [-1,1], [-1,-1], [1,-1]]
    vectors.each do |vector|
      return true if four_vector?(vector, pos)
    end
    return false
  end

  def four_vector?(vector, pos)
    color = self[pos]
    (1..3).each do |i|
      new_pos = [pos[0] + i * vector[0], pos[1] + i * vector[1]]
      break if !(0..5).include?(new_pos[0]) || !(0..6).include?(new_pos[1])
      break if self[new_pos] != color || self[new_pos].nil?
      return true if i == 3
    end
    false
  end
end
