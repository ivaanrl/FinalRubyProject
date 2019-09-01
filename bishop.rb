require_relative 'piece'

class Bishop < Piece
  attr_accessor :piece, :position
  def initialize(color)
    @@number_of_white = 0
    @@number_of_black = 0
    if color == 'white'
      @piece = "\u2657 "
      if @@number_of_white == 0
        @position = [1,3]
        @@number_of_white += 1
      else
        @position = [1,6]
      end
    else  
      @piece = "\u265D "
      if @number_of_black == 0
        @position = [8,3]
        @@number_of_black += 1
      else
        @position = [8,6]
      end
    end
  end

  def self.error
    "That's not a valid move. Bishops can only move diagonally."
  end

  def move(initial_square, target_square, taken, turn)
    @position = initial_square
    if turn != taken[1]
      @position = target_square
      return true
    elsif turn == taken[1]
      puts "There's another #{turn} piece there. Please choose your coordinates again."
    end
  end
end
