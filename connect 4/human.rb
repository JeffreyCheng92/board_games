class HumanPlayer

  attr_reader :player_number, :marker

  def initialize(player_number, marker)
    @player_number = player_number
    @marker = marker
  end

  def get_column
    col = prompt
    until valid_column?(col)
      puts "Not a valid column!"
      col = prompt
    end
    col
  end

  private

  def valid_column?(col)
    (0..6).include?(col)
  end

  def prompt
    print "Player #{player_number + 1}, pick a column: "
    gets.chomp.to_i
  end

end
