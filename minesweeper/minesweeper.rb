load 'board.rb'
load 'tile.rb'
require 'yaml'

class Minesweeper
  attr_reader :board

  def initialize
    load_game
  end

  def play
    until won?
      board.render
      choice = decision

      if choice == "s"
        save
        return
      end

      current_pos = get_pos
      if choice == "r"
        # check if lost in Board#revealer method
        if lost?(current_pos)
          board.render
          print "You lost the game!"
          # break
          # return
        end
        board.revealer(current_pos)
      else
        flag_cases(choice, current_pos)
      end
    end

    print "You beat the game!"
  end


  private

  def flag_cases(choice, current_pos)
    case choice
    when "f"
      if !board[current_pos].revealed
        flag_helper(true, current_pos)
      else
        puts "Cannot flag a revealed position"
        sleep(2)
      end
    else
      if board[current_pos].flagged
        flag_helper(false, current_pos)
      else
        puts "Can only unflag a flagged position"
        sleep(2)
      end
    end
  end

  def flag_helper(boolean, current_pos)
    board[current_pos].flagged = boolean
    board[current_pos].revealed = boolean
  end

  def load_game
    puts "Do you have an old game to load? (y or n)"
    choice = confirm_load_input
    if choice == "y"
      load_helper
    else
      @board = Board.new
    end
  end

  def load_helper
    puts "What is the file name?"
    file = gets.chomp.downcase
    @board = YAML.load_file(file).board
  end

  def lost?(pos)
    board[pos].revealed = true if board[pos].bombed?
    board[pos].bombed?
  end

  def decision
    puts "Do you want to (f)lag, (u)nflag, (r)eveal, or (s)ave/quit?"
    confirm_decision_input
  end

  def won?
    board.won?
  end

  def save
    temp = self.to_yaml
    File.open('save.yml', 'w') {|f| f.puts temp}
  end

  def get_pos
    puts "What row do pick?"
    row = confirm_input
    puts "What column do you pick?"
    col = confirm_input
    [row, col]
  end

  def confirm_load_input
    choice = gets.chomp.downcase[0]
    until choice == "y" || choice == "n"
      puts "Please pick yes or no (y or n)"
      choice = gets.chomp.downcase[0]
    end
    choice
  end

  def confirm_input
    num = gets.chomp.to_i
    until num.between?(0, 8)
      puts "Pick valid number between 0 and 8."
      num = gets.chomp.to_i
    end
    num
  end

  def confirm_decision_input
    choice = gets.chomp.downcase[0]
    # until choice == "f" || choice == "u" || choice == "r" || choice == "s"
    until %w(f u r s).include?(choice)
      puts "Pick (f)lag, (u)nflag, (r)eveal, or (s)ave/quit."
      choice = gets.chomp.downcase[0]
    end

    choice
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Minesweeper.new
  game.play
end
