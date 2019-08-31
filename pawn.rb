require_relative 'piece'

class Pawn < Piece
  attr_accessor :piece
  def initialize(color)
    @move_count = 0
    color == 'white' ? @piece = "\u2659 " : @piece = "\u265F "
  end

  def self.move(initial_square, target_square)
    if @move_count == 0
      if initial_square[0] + 1 == target_square[0] || initial_square[0] + 2 == target_square[0]
        @move_count += 1
        return true 
      end
    elsif initial_square[0] + 1 == target_square[0]
        return true
    else 
      puts "That's not a valid Pawn move."
    end
  end 
end