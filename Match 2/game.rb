require_relative "board"
require_relative "player"

class Game
  attr_reader :board, :player, :previous_card, :turns

  def initialize(num, player)
    @board = Board.new(num)
    @player = player
    @previous_card = nil
    @turns = num ** 2
  end

  def play
    board.populate
    until board.won? || turns.zero?
      board.render
      pos = guess_until_valid
      board.render
      handle_guess(pos)
    end
    puts board.won? ? "You win!" : "You lose!"
  end

  private

  def handle_guess(pos)
    if previous_card
      hide(pos, previous_card) if not board.match?(pos, previous_card)
      @previous_card = nil
      sleep(2) if not board.won?
      @turns -= 1
    else
      @previous_card = pos
    end
  end

  def hide(pos1, pos2)
    board[*pos1].hide
    board[*pos2].hide
  end

  def guess_until_valid
    pos = nil
    pos = player.get_card(board) until checks(pos)
    board[*pos].reveal
    pos
  end

  def checks(pos)
    return false if pos.nil?
    if not on_board?(pos)
      puts "Pick a spot on the board."
      return false
    elsif not valid_move?(pos)
      puts "That card is already revealed."
      return false
    end
    true
  end

  def valid_move?(pos)
    return board[*pos].revealed ? false : true
  end

  def on_board?(pos)
    (pos[0] < board.size && pos[0] >= 0) &&
    (pos[1] >= 0 && pos[1] < board.size)
  end

end

if __FILE__ == $PROGRAM_NAME
  value = ARGV.shift
  num = 6 if value == "hard"
  num = 4 if value == "medium"
  num = 2 if value == "easy"
  g = Game.new(num, HumanPlayer.new)
  g.play
end
