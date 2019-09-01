require_relative 'piece'

class Knight < Piece
  attr_accessor :piece
  def initialize(color)
    color =='white' ? @piece = "\u2658 " : @piece = "\u265E "
  end

  def self.move(initial_square, target_square, taken, turn)
    if turn != taken[1]
      if (initial_square[0] + 2 == target_square[0] && (initial_square[1] + 1 == target_square[1] || initial_square[1] - 1 == target_square[1])) ||
         (initial_square[0] - 2 == target_square[0] && (initial_square[1] + 1 == target_square[1] || initial_square[1] - 1 == target_square[1])) ||
         (initial_square[1] + 2 == target_square[1] && (initial_square[0] + 1 == target_square[0] || initial_square[0] - 1 == target_square[0])) ||
         (initial_square[1] - 2 == target_square[1] && (initial_square[0] + 1 == target_square[0] || initial_square[0] - 1 == target_square[0]))
          return true 
      else  
        puts "That's not a valid move. Knights can only move in L shape."
      end
    elsif turn == taken[1]
      puts "There's another #{turn} piece there. Please choose your coordinates again."
    end
  end
end