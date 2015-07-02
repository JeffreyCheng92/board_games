load "emptypiece.rb"
load 'piece.rb'

require 'byebug'
require 'colorize'

class Board
  attr_reader :grid
  attr_accessor :active_moveset

  COLORS = [:red, :light_black]

  def initialize
    @grid = Array.new(8){ Array.new(8) {EmptyPiece.new} }
    @active_moveset = []
  end

  def seed_pieces
    seed_black_pieces
    seed_white_pieces
  end

  def seed_white_pieces
    (0..2).each do |row|
      if row.even?
        (0..7).each do |col|
          self[[row, col]] = Piece.new(self, [row, col], :white) if col.odd?
        end
      else
        (0..7).each do |col|
          self[[row, col]] = Piece.new(self, [row, col], :white) if col.even?
        end
      end
    end
  end

  def seed_black_pieces
    (5..7).each do |row|
      if row.odd?
        (0..7).each do |col|
          self[[row, col]] = Piece.new(self, [row, col], :black) if col.even?
        end
      else
        (0..7).each do |col|
          self[[row, col]] = Piece.new(self, [row, col], :black) if col.odd?
        end
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

    puts "    A  B  C  D  E  F  G  H"
    @grid.each_with_index do |row, i|
      bg_constant = i % 2
      row_string = row.map.with_index do |piece, j|
        if [i, j] == cursor
          self[[i, j]].to_s.colorize(:background => :yellow)
        elsif active_moveset.include?([i, j])
          self[[i, j]].to_s.colorize(:background => :green)
        elsif bg_constant
          bg_color = COLORS[(bg_constant + j) % 2]
          self[[i, j]].to_s.colorize(:background => bg_color)

        end
      #  cursor_helper(i, j, possible_moves, cursor)

      end
      puts "#{i.to_s}  #{row_string.join}"
    end
  end

  def inspect
    nil
  end

  def on_board?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  private

  # def cursor_helper(idx1, idx2, moves_array, cursor)
  #   if [idx1, idx2] == cursor
  #     self[[idx1, idx2]].to_s.colorize(:background => :yellow)
  #   elsif moves_array.include?([idx1, idx2])
  #     self[[idx1, idx2]].to_s.colorize(:background => :green)
  #   else
  #     render_helper(idx1, idx2)
  #   end
  # end






end
