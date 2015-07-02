load 'board.rb'
load 'player.rb'
load 'piece.rb'
load 'emptypiece.rb'
load 'keypress.rb'

class Checkers

end


b = Board.new
b.seed_pieces
p b[[5,0]].possible_moves
p b[[5,0]].perform_slide([4,4])
# p = Player.new(b, :red)
# b.render(p.cursor)
# p.move_cursor
