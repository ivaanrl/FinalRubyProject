require_relative 'piece'

class Rook < Piece
  attr_accessor :piece, :position
  def initialize(color) 
      @@number_of_white = 0
      @@number_of_black = 0
    if color == 'white'
      @piece = "\u2656 "
      if @@number_of_white == 0
        @position = [1,1]
        @@number_of_white += 1
      else
        @position = [1,8]
      end
    else  
      @piece = "\u265C "
      if @number_of_black == 0
        @position = [8,1]
        @@number_of_black += 1
      else
        @position = [8,8]
      end
    end
  end

  def self.error
    "That's not a valid move. Rooks can only move horizontally OR vertically."
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