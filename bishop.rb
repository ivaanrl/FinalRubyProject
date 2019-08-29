require_relative 'piece'

class Bishop < Piece
  attr_accessor :piece
  def initialize(color)
    color == 'white' ? @piece = "\u2657 " : @piece = "\u265D "
  end
end
