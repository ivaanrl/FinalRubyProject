require_relative 'piece'

class Queen< Piece
  attr_accessor :piece
  def initialize(color)
    color == 'white' ? @piece = "\u2655 " : @piece = "\u265B "
  end
end