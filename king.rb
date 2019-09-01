require_relative 'piece'

class King < Piece
  attr_accessor :piece
  def initialize(color)
    color == 'white' ? @piece = "\u2654 " : @piece = "\u265A "
  end

  def self.move(initial_square, target_square, taken, turn)
    if turn != taken[1]
      if ((initial_square[0] + 1 == target_square[0]) || (initial_square[0] - 1 == target_square[0])) ||
      ((initial_square[1] + 1 == target_square[1]) || (initial_square[1] - 1 == target_square[1])) ||
      ((initial_square[0] + 1 == target_square[0] && initial_square[1] + 1 == target_square[1])) ||
      ((initial_square[0] + 1 == target_square[0] && initial_square[1] - 1 == target_square[1])) ||
      ((initial_square[0] - 1 == target_square[0] && initial_square[1] + 1 == target_square[1])) ||
      ((initial_square[0] - 1 == target_square[0] && initial_square[1] - 1 == target_square[1]))
        return true 
      else  
        puts "That's not a valid move. King can only move one square away from him."
      end
    elsif turn == taken[1]
      puts "There's another #{turn} piece there. Please choose your coordinates again."
    end
  end
end