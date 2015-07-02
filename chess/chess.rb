class CheckError < StandardError


end

load 'board.rb'
load 'player.rb'

class Chess
  attr_reader :board, :player1, :player2, :players
  attr_accessor :selected, :start_pos, :end_pos

  def initialize
    @board = Board.new
    @player1 = Player.new(board, "red")
    @player2 = Player.new(board, "blue")
    @players = [player1, player2]
    @start_pos = nil
    @end_pos = nil

  end


  def test
    board.seed_pieces

    @board.render(players.last.cursor)
    begin
      until won?
        puts "#{players.first.color.capitalize}'s Turn"
        puts "Check" if @board.check?(players)


        @start_pos = get_start_move

        board.selected_moves = board[start_pos].possible_moves
        board.selected = true

        @end_pos = get_end_move

        players.last.cursor = end_pos
        board.selected = false
        
        move_piece

        if @board.check?(players)
          board[end_pos].escape_check(start_pos)
          raise CheckError.new("Check!")
        end

        change_turn
      end

    rescue CheckError => e
      puts e.message
      retry

    end
  end
  private

  def change_turn
    @players.rotate!
  end

  def won?
    @board.check_mate?(players)
  end

  def get_start_move
    start_pos = players.first.move_cursor
    until board[start_pos].color == players.first.color
      puts "Pick piece of your own color."
      start_pos = players.first.move_cursor
    end
    start_pos
  end

  def get_end_move
    end_pos = players.first.move_cursor
    until board[start_pos].possible_moves.include?(end_pos)
      puts "Pick valid position."
      end_pos = players.first.move_cursor
    end

    end_pos
  end

  def move_piece
    board[start_pos].move!(end_pos)
  end


end

 g = Chess.new
 g.test
