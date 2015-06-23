class Player



end

class HumanPlayer < Player

  def initialize
  end

  def get_card(board)
    print "Pick a card: "
    gets.chomp.split(", ").map{ |i| i.to_i}
  end

end

class ComputerPlayer < Player
  attr_reader :board, :information

  def initialize
    @board = Board.new(6)
    @board.populate
    @information = Hash.new(Array.new)
  end

  def get_card
    pos = [ rand(board.size), rand(board.size) ]
    pos = [ rand(board.size), rand(board.size) ] until new_guess?(pos)
    @information[ board[*pos] ] <<  pos
  end

  def new_guess?(pos)

  end

  def psychic
    information.each do |key, value|
      if value.length == 2
        return board[*value[0]].revealed ? value[1] : value[0]
      end
    end

  end

end
