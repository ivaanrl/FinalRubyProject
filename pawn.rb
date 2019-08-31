require_relative 'piece'

class Pawn < Piece
  attr_accessor :piece
  def initialize(color)
    color == 'white' ? @piece = "\u2659 " : @piece = "\u265F "
  end

  def self.move(initial_square, target_square, taken, turn)
    if taken[0] 
      if turn != taken[1]
        if initial_square[0] + 1 == target_square[0] && initial_square[1] + 1 == target_square[1]
          return true
        else
          puts "There's another piece there. Pawns can only eat in diagonal."
        end
      else
        puts "There's another #{turn} piece there. Choose another move"
      end
    else
      if (initial_square[0] == 2 && turn == 'white') || (initial_square[0] == 7 && turn == 'black')
        if initial_square[0] + 1 == target_square[0] || initial_square[0] + 2 == target_square[0]
          return true 
        end
      elsif initial_square[0] + 1 == target_square[0]
          return true
      else 
        puts "That's not a valid Pawn move. Choose your coordinates again."
      end
    end
  end 
end