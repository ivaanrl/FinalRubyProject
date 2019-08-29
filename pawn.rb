require_relative 'piece'

class Pawn < Piece
  attr_accessor :piece
  def initialize(color)
    color == 'white' ? @piece = "\u2659 " : @piece = "\u265F "
  end
end