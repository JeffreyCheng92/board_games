load "emptypiece.rb"
load 'piece.rb'

require 'byebug'
require 'colorize'

class Board
  attr_reader :grid
  attr_accessor :active_moveset, :selected, :selected_moveset

  COLORS = [:red, :light_black]
  BLACK_ROWS = [5, 6, 7]
  WHITE_ROWS = [0, 1, 2]

  def initialize
    @grid = Array.new(8){ Array.new(8) {EmptyPiece.new} }
    @active_moveset = []
    @selected = false
    seed_pieces
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
      bg_constant = (i % 2)
      row_string = row.map.with_index do |piece, j|
        @active_moveset = selected_moveset if selected

        if [i, j] == cursor
          self[[i, j]].to_s.colorize(:background => :yellow)
        elsif active_moveset.include?([i, j])
          self[[i, j]].to_s.colorize(:background => :green)
        elsif bg_constant
          bg_color = COLORS[(bg_constant + j) % 2]
          self[[i, j]].to_s.colorize(:background => bg_color)
        end

      end
      puts "#{i.to_s}  #{row_string.join}"
    end
  end

  def on_board?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def game_over?
    all_pieces_same_color?
  end

  private

  def inspect
    nil
  end

  def all_pieces_same_color?
    all_pieces_black? || all_pieces_white?
  end

  def all_pieces_black?
    grid.flatten.all? { |piece| piece.color == :black || piece.color == ""}
  end

  def all_pieces_white?
    grid.flatten.all? { |piece| piece.color == :white|| piece.color == ""}
  end

  def seed_pieces
    positions = [0, 2, 4 ,6]
    (0..7).each do |row|
      seed_constant = row % 2
      if WHITE_ROWS.include?(row)
        positions.each do |num|
          col = seed_constant + num
          self[[row, col]] = Piece.new(self, [row, col], :white)
        end
      elsif BLACK_ROWS.include?(row)
        positions.each do |num|
          col = seed_constant + num
          self[[row, col]] = Piece.new(self, [row, col], :black)
        end
      end
    end
  end

end
