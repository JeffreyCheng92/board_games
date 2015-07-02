class Player
  require_relative 'keypress'
  require 'byebug'

  attr_accessor :cursor, :board
  attr_reader :color

  def initialize(board, color)
    @cursor = [0, 0]
    @board = board
    @color = color

  end

  KEYS = [
    "\e[A",
    "\e[B",
    "\e[C",
    "\e[D",
    "\r"
  ]

  def move_cursor

      while true
        char = read_char
        break unless handle_cursor(char)
      end
      cursor
  end

  private


  def handle_cursor(input)

    row, col = cursor

    case input
    when "\e[A"
      row -= 1
    when "\e[B"
      row += 1
    when "\e[C"
      col +=1
    when "\e[D"
      col -= 1
    when "\r"
      self.cursor = [row, col]
      return false
    else
      exit
    end

    @cursor = [keep_within_bounds(row), keep_within_bounds(col)]

    board.render(cursor)
  end

  def keep_within_bounds(num)
    [0, [num, 7].min].max
  end



end
