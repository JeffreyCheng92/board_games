require 'colorize'
require_relative 'board'
require_relative 'human'

class Game
  attr_reader :board, :players

  def initialize
    @board = Board.new
    @players = [HumanPlayer.new(0,"o".colorize(:red)), HumanPlayer.new(1, "o".colorize(:black))]
  end

  def run
    i = 0

    until board.over?
      board.render
      dropped = board.drop_disc(players[i].get_column, players[i].marker)
      until dropped
        puts "Unavailable move!"
        dropped = board.drop_disc(players[i].get_column, players[i].marker)
      end

      i = (i + 1) % 2
    end

    board.render

    puts "Player #{(i + 1) % 2 + 1} wins!"
  end

end
