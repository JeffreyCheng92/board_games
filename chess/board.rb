load "EmptyPiece.rb"
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
    pieces = [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]

    @grid[0].each_index do |idx|
      self[[0, idx]] = pieces[idx].new(self, [0, idx], "blue")
    end
    @grid[7].each_index do |idx|
      self[[7, idx]] = pieces[idx].new(self, [7, idx], "red")
    end

    seed_pawns

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


  def check?(players)
    king_pos = get_own_king(players)
    other_pos = other_color_moves(players)
    other_pos.include?(king_pos)
  end


  def check_mate?(players)

    return false if !check?(players)

    kings_moves = get_kings_moves(players)

    own_pieces = get_own_color_pieces(players)

    own_pieces.each do |piece|
      moves = piece.possible_moves
      start_pos = piece.pos

      moves.each do |end_pos|
        piece = !self[end_pos].empty? ? self[end_pos] : EmptyPiece.new
        self[start_pos].move!(end_pos)
        if !check?(players)
          self[end_pos].escape_check(start_pos)
          self[end_pos] = piece
          self.render(end_pos)
          return false
        else
          self[end_pos].escape_check(start_pos)
          self[end_pos] = piece
        end

      end
    end
    puts "#{players.second.capitalize} Wins!"
    true
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

  def get_own_color_pieces(players)
    @grid.flatten.select { |piece| piece.color == players.first.color }
  end

  def get_kings_moves(players)
    king_pos = get_own_king(players)
    self[king_pos].possible_moves
  end

  def get_own_king(players)
    @grid.flatten.each do |piece|
      return piece.pos if piece.color == players.first.color && piece.is_a?(King)
    end
  end

  def get_other_color_pieces(players)
    @grid.flatten.select { |piece| piece.color == players[1].color }
  end

  def other_color_moves(players)
    pieces = get_other_color_pieces(players)
    all_possible_moves = []
    pieces.each { |piece| all_possible_moves += piece.possible_moves }

    all_possible_moves
  end

  def seed_pawns
    [[1, "blue"], [6, "red"]].each do |place|
      grid[place[0]].each_with_index do |tile, idx|
         self[[place[0], idx]] = Pawn.new(self, [place[0], idx], place[1])
      end
    end
  end


  def render_helper(idx1, idx2)
    color_switch = [self[[idx1, idx2]].to_s.colorize(:background => :white),
      self[[idx1, idx2]].to_s.colorize(:background => :black)]

    if idx1.even?
       idx2.even? ? color_switch[0] : color_switch[1]
    else
       idx2.even? ? color_switch[1] : color_switch[0]
    end
  end




end
