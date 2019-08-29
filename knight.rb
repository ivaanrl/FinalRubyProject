require_relative 'piece'

class Knight < Piece
  attr_accessor :piece
  def initialize(color)
    color =='white' ? @piece = "\u2658 " : @piece = "\u265D "
  end
end