require_relative 'piece'

class Rook < Piece
  attr_accessor :piece
  def initialize(color) 
    color == 'white' ? @piece = "\u2656 " : @piece = "\u265C "
  end
end