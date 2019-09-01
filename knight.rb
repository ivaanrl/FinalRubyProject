require_relative 'piece'

class Knight < Piece
  attr_accessor :piece, :position
  def initialize(color)
    @@number_of_black = 0
    @@number_of_white = 0
    if color == 'white'
      @piece = "\u2658 "
      if @@number_of_white == 0
        @position = [1,2]
        @@number_of_white += 1
      else
        @position = [1,7]
      end
    else  
      @piece = "\u265E "
      if @number_of_black == 0
        @position = [8,2]
        @@number_of_black += 1
      else
        @position = [8,7]
      end
    end
  end

  def self.error
    "That's not a valid move. Knights can only move in L shape."
  end
  def move(initial_square, target_square, taken, turn)
    if turn != taken[1]
      if (initial_square[0] + 2 == target_square[0] && (initial_square[1] + 1 == target_square[1] || initial_square[1] - 1 == target_square[1])) ||
         (initial_square[0] - 2 == target_square[0] && (initial_square[1] + 1 == target_square[1] || initial_square[1] - 1 == target_square[1])) ||
         (initial_square[1] + 2 == target_square[1] && (initial_square[0] + 1 == target_square[0] || initial_square[0] - 1 == target_square[0])) ||
         (initial_square[1] - 2 == target_square[1] && (initial_square[0] + 1 == target_square[0] || initial_square[0] - 1 == target_square[0]))
          @position = target_square
          return true 
      end
    elsif turn == taken[1]
      puts "There's another #{turn} piece there. Please choose your coordinates again."
    end
  end
end