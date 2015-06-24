require "colorize"

class Tile

  attr_reader :num, :given

  def initialize(num = 0, given = false)
    @given = given
    @num = num
  end

  def to_s
    if num == 0
      return " "
    elsif given
      return num.to_s.colorize(:blue)
    else
      return num.to_s.colorize(:red)
    end
  end
end
