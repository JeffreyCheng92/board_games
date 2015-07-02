load "emptypiece.rb"
load 'piece.rb'

require 'byebug'
require 'colorize'

class Board
  attr_accessor :move_array, :selected, :selected_moves
  attr_reader :grid


  def initialize
    @grid = Array.new(8){ Array.new(8) {EmptyPiece.new}  }
    @selected = false
    @selected_moves = []
  end

  def seed_pieces
    [[1, "blue"], [6, "red"]].each do |place|
      grid[place[0]].each_with_index do |tile, idx|
         self[[place[0], idx]] = Pawn.new(self, [place[0], idx], place[1])
      end
    end


  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos,value)
    row, col = pos
    @grid[row][col] = value
  end

  def render(cursor)
    system("clear")
    possible_moves = []

    if selected
      possible_moves = selected_moves
      selected = false

    else
      possible_moves = self[cursor].possible_moves unless self[cursor].empty?
    end

    puts "    A   B   C   D   E   F   G   H"
    @grid.each_with_index do |row, i|
      row_string = row.map.with_index do |piece, j|

        cursor_helper(i, j, possible_moves, cursor)

      end
      puts "#{i.to_s}  #{row_string.join}"
    end
  end





  private

  def cursor_helper(idx1, idx2, moves_array, cursor)
    if [idx1, idx2] == cursor
      self[[idx1, idx2]].to_s.colorize(:background => :yellow)
    elsif moves_array.include?([idx1, idx2])
      self[[idx1, idx2]].to_s.colorize(:background => :green)
    else
      render_helper(idx1, idx2)
    end
  end




  def render_helper(idx1, idx2)
    color_switch = [self[[idx1, idx2]].to_s.colorize(:background => :red),
      self[[idx1, idx2]].to_s.colorize(:background => :black)]

    if idx1.even?
       idx2.even? ? color_switch[0] : color_switch[1]
    else
       idx2.even? ? color_switch[1] : color_switch[0]
    end
  end




end
