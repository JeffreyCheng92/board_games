load 'board.rb'
load 'player.rb'
load 'piece.rb'
load 'emptypiece.rb'
load 'keypress.rb'

class Checkers

end


b = Board.new

b.seed_pieces
# b[[5,0]] = Piece.new(b, [5,0], :black)
# b[[4,1]] = Piece.new(b, [4,1], :white)
# p b[[5,0]].possible_moves
p = Player.new(b, :red)
b.render(p.cursor)
p.move_cursor
