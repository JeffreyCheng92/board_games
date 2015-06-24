require_relative "board"

class Game

  def initialize(text = "sudoku1.txt")
    @board = Board.from_file(text)
  end

  def play
    until board.solved?
      board.render
      board[get_valid_move] = prompt_num
    end
    puts "You won!"
  end

  private
  
  attr_reader :board

  def get_valid_move
    pos = prompt_position
    until !invalid_move?(pos)
      puts "Pick again!"
      pos = prompt_position
    end
    pos
  end

  def prompt_num
    print "What value do you want to place? "
    gets.chomp.to_i
  end

  def invalid_move?(pos)
    return board[pos].given || !place?(pos)
  end

  def place?(pos)
    return true if board[pos].num == 0
    print "Warning! Are you sure you want to replace tile? (y / n)"
    return gets.chomp.downcase == "y" ? true : false
  end

  def prompt_position
    print "Enter row number: "
    row = gets.chomp.to_i
    print "Enter column number: "
    column = gets.chomp.to_i
    [row, column]
  end

end
