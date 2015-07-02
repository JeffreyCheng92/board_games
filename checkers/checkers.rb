load 'board.rb'
load 'player.rb'
load 'piece.rb'
load 'emptypiece.rb'
load 'keypress.rb'

require "byebug"

class InvalidSelectionError < StandardError
end

class InvalidMoveError < StandardError
end

class Checkers
  attr_reader :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new(board, :white), Player.new(board, :black)]
  end

  def play
    board.render([0,0])
    until board.game_over?
        current_player = players.first
        start_pos = get_start_pos(current_player)
        end_pos = get_end_pos(current_player, start_pos)
        board[start_pos].move!(end_pos)
        board.render(end_pos)
        players.last.cursor = end_pos
        change_turn
    end
  end

  def get_start_pos(player)
    begin
      start_pos = player.move_cursor
      if board[start_pos].color != player.color ||
        board[start_pos].possible_moves.length <= 0
        raise InvalidSelectionError
      end
    rescue InvalidSelectionError
      puts "Thats either not your piece or you arent able to move it."
      retry
    end
    board.selected = true
    start_pos
  end

  def get_end_pos(player, start_pos)
    begin
      end_pos = player.move_cursor
      moveset = board[start_pos].possible_moves
      raise InvalidMoveError unless moveset.include?(end_pos)
    rescue InvalidMoveError
      puts "That's not a valid move bro..."
      retry
    end
    board.selected = false
    end_pos
  end

  def change_turn
    @players.rotate!
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Checkers.new
  b.play

end
