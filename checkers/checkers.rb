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
  attr_reader :board, :players, :multiple_jump

  def initialize
    @board = Board.new
    @players = [Player.new(board, :white), Player.new(board, :black)]
    @multiple_jump = false
  end

  def play
    board.render([0,0])

    until board.game_over?
        current_player = players.first
        puts "#{current_player.color.to_s.capitalize}'s turn!"

        start_pos = get_start_pos(current_player)
        end_pos = get_end_pos(current_player, start_pos)

        jump_again = false
        until jump_again
          # debugger
          if @multiple_jump || board[start_pos].possible_jumps.include?(end_pos)

              board[start_pos].move!(end_pos) unless board[start_pos].empty?

              if board[end_pos].empty?
                jump_again = true
              elsif board[end_pos].possible_jumps.length == 1
                force_jump(board, end_pos)
                jump_again = true
              elsif board[end_pos].possible_jumps.length > 1
                start_pos = end_pos
                multipos_jump_selector(current_player, board, start_pos)
              else
                jump_again = true
              end
          else
            jump_again = true
            board[start_pos].move!(end_pos) unless board[start_pos].empty?
          end
        end

        finish_turn(end_pos)

    end
    puts "#{players.last.color.to_s.capitalize} has won!"
  end

  private

  def multipos_jump_selector(current_player, board, start_pos)
    begin
      end_pos = current_player.move_cursor
      unless board[start_pos].possible_jumps.include?(end_pos)
        raise InvalidSelectionError
      end
    rescue InvalidSelectionError
      puts "Thats not a valid jump location."
      retry
    end
    board[start_pos].move!(end_pos)
    @multiple_jump = true
  end

  def force_jump(board, end_pos)
    start_pos = end_pos
    end_pos = board[start_pos].possible_jumps.first
    board[start_pos].move!(end_pos)
    @multiple_jump = false
  end

  def finish_turn(end_pos)
    board.render(end_pos)
    players.last.cursor = end_pos
    change_turn
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
    board.selected_moveset = board[start_pos].possible_moves
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

  # b = Board.new
  # b[[1,1]] = Piece.new(b, [1,1], :white)
  # b[[3,1]] = Piece.new(b, [3,1], :white)
  # b[[4,2]] = Piece.new(b, [4,2], :black, true)
  # # debugger
  #
  # p b[[4,2]].possible_moves
end
