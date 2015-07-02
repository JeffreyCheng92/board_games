load "emptypiece.rb"
load 'piece.rb'

require 'byebug'
require 'colorize'

class Board
  attr_reader :grid


  def initialize
    @grid = Array.new(8){ Array.new(8) {EmptyPiece.new}  }
    @cursor = [0,0]
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
    # possible_moves = []
    #
    # if selected
    #   possible_moves = selected_moves
    #   selected = false
    #
    # else
    #   possible_moves = self[cursor].possible_moves unless self[cursor].empty?
    # end

    puts "    A   B   C   D   E   F   G   H"
    @grid.each_with_index do |row, i|
      row_string = row.map.with_index do |piece, j|
        if [i, j] == cursor
          self[[i, j]].to_s.colorize(:background => :yellow)
        # elsif (HIGHLIGHT MOVES HERE)
        # HIGHLIGHT MOVES HERE
        #HIGHLIGHT MOVES HERE
        elsif i.even?
          if j.odd?
            self[[i,j]].to_s.colorize(background: :red)
          else
            self[[i,j]].to_s.colorize(background: :light_black)
          end
        else
          if j.even?
            self[[i,j]].to_s.colorize(background: :red)
          else
            self[[i,j]].to_s.colorize(background: :light_black)
          end
        end
      #  cursor_helper(i, j, possible_moves, cursor)

      end
      puts "#{i.to_s}  #{row_string.join}"
    end
  end

  def inspect
    nil
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
