require_relative 'piece'

class Queen< Piece
  attr_accessor :piece
  def initialize(color)
    color == 'white' ? @piece = "\u2655 " : @piece = "\u265B "
  end

  def self.move(initial_square, target_square, taken, turn)
    if turn != taken[1]
      return true
    elsif turn == taken[1]
      puts "There's another #{turn} piece there. Please choose your coordinates again."
    end
  end
end