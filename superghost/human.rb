class Human
  attr_reader :player_number, :lives

  def initialize(num)
    @player_number = num
    @lives = 5
  end

  def front_back
    position = get_position
    until valid_position?(position)
      puts "Please pick (f) or (b)."
      position = get_position
    end

    position
  end

  def player_turn
    letter = get_letter
    until valid_letter?(letter)
      puts "Please pick a valid letter (a - z)."
      letter = get_letter
    end

    letter
  end

  def lose_life
    @lives -= 1
  end

  private

  def get_position
    print "Player #{player_number}, choose (f)ront or (b)ack: "
    gets.chomp.downcase
  end

  def valid_position?(position)
    position[0] == "f" || position[0] == "b"
  end

  def get_letter
    print "Player #{player_number}, choose a letter: "
    gets.chomp.downcase
  end

  def valid_letter?(letter)
    !!(letter =~ /[a-z]/) && letter.length == 1
  end
end
