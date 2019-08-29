require_relative 'piece'
require_relative 'bishop'
require_relative 'pawn'
require_relative 'queen'
require_relative 'king'
require_relative 'knight'
require_relative 'rook'

class Board


  def initialize
    @board = Array.new(9) {Array.new(9)}
    assing_pieces
    display_board
  end

  def assing_pieces
    assign_whites
    assing_blacks
    assign_empty
    assing_labels
    place_pieces
    place_empty
  end

  def assign_whites
    @w_pawn = Array.new(8, Pawn.new('white'))
    @w_king = King.new('white')
    @w_queen = Queen.new("white")
    @w_rook = Rook.new("white")
    @w_bishop = Bishop.new("white")
    @w_knight = Knight.new("white")

  end

  def assing_blacks
    @b_pawn = Array.new(8,Pawn.new('black'))
    @b_king = King.new('black')
    @b_queen = Queen.new('b')
    @b_rook = Rook.new('b')
    @b_bishop = Bishop.new('b')
    @b_knight = Knight.new('b')
  end

  def place_pieces
    i = 1
    while i<9 #places b&w pawns
      @board[2][i] = @b_pawn[i-1].piece
      @board[7][i] = @w_pawn[i-1].piece
      i += 1
    end
    
    @board[1][5] = @b_king.piece #places kings
    @board[8][5] = @w_king.piece#

    @board[1][1] = @b_rook.piece #places rooks
    @board[1][8] = @b_rook.piece #
    @board[8][1] = @w_rook.piece #
    @board[8][8] = @w_rook.piece #

    @board[1][2] = @b_knight.piece #places knights
    @board[1][7] = @b_knight.piece # 
    @board[8][2] = @w_knight.piece # 
    @board[8][7] = @w_knight.piece # 

    @board[1][3] = @b_bishop.piece #places bishops
    @board[1][6] = @b_bishop.piece #
    @board[8][3] = @w_bishop.piece #
    @board[8][6] = @w_bishop.piece #

    @board[1][4] = @b_queen.piece#places queens
    @board[8][4] = @w_queen.piece#
  end
  
  def assign_empty
    @empty = "\u25A1 "
  end

  def place_empty
    for i in 3..6 do
      for j in 1..8 do
        @board[i][j] = @empty
      end
    end
  end

  def assing_labels
    label ='a'
    for i in 1..8 do
      @board[0][i] = ' ' + label
      label = label.next
      @board[i][0] = i
    end

  end

  def display_board
    puts
    puts @board.reverse.map { |row| row.map { |value| ' ' + value.to_s + ' '}.join}
    puts "\n"
  end
end

w = Board.new

