require_relative 'piece'

class King < Piece
  attr_accessor :piece
  def initialize(color)
    color == 'white' ? @piece = "\u2654 " : @piece = "\u265A "
  end
end