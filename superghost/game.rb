require "set"
require_relative "human.rb"

class Game
  attr_reader :dictionary, :fragment, :players

  def initialize
    @dictionary = read_dictionary("dictionary.txt")
    @fragment = ""
    @players = []
  end

  def play
    setup
    until over?
      render
      player = players[0]
      display_lives(player.lives)
      char = player.player_turn
      position = player.front_back == "b"

      until valid_letter?(char, position)
        print position ? "#{fragment}#{char}" : "#{char}#{fragment}"
        puts " is not the beginning of a word, pick again."
        char = player.player_turn
        position = player.front_back == "b"
      end
      position ? fragment << char : @fragment = char + fragment
      if is_word?
        player.lose_life
        puts "Player #{player.player_number} spelled '#{fragment}' and lost a life"
        sleep(2)
        @fragment = ""
      end
      switch
      eliminate(player)
    end
    puts "Player #{player[0].player_number} wins!"
  end

  private

  def valid_letter?(char, position)
    temp_fragment = position ? fragment + char : char + fragment
    dictionary.each do |word|
      return true if word.slice(0, temp_fragment.length) == temp_fragment
    end
    false
  end

  def setup
    number = player_promt
    until number.between?(2, 9)
      puts "That is not a number between 2 and 9!"
      number = player_promt
    end
    generate_players(number)
  end

  def generate_players(number)
    1.upto(number) { |player_number| players << Human.new(player_number) }
  end

  def player_promt
    print "How many players are playing (2 to 9): "
    Integer(gets.chomp)
  end

  def render
    system("clear")
    puts "The current fragment is: '#{fragment}'"
  end

  def display_lives(lives)
    array = ["GHOST", "GHOS", "GHO", "GH", "G", ""]
    print "[ #{array[lives]} ] "
  end

  def is_word?
    dictionary.include?(fragment)
  end

  def over?
    players.length == 1
  end

  def eliminate(player)
    if player.lives.zero?
      players.pop
      system("clear")
      puts "[ GHOST ] Game over for Player #{player.last.player_number}!"
    end
  end

  def switch
    @players << @players.shift
  end

  def read_dictionary(file)
    dictionary_array = File.readlines(file).map(&:chomp)
    dictionary_set = Set.new(dictionary_array)
  end

  def inspect
    nil
  end

end
