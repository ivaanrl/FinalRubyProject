require_relative 'piece'

class Queen< Piece
  attr_accessor :piece, :position
  def initialize(color)
    color == 'white' ? @piece = "\u2655 " : @piece = "\u265B "
    color == 'white' ? @position = [1,4]  : @position = [8,4]
  end

  def move(initial_square, target_square, taken, turn)
    if turn != taken[1]
      @position = target_square
      return true
    elsif turn == taken[1]
      puts "There's another #{turn} piece there. Please choose your coordinates again."
    end
  end
end