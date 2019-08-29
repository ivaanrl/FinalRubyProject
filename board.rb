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
    @w_pawn = "\u2659 "
    @w_king = "\u2654 "
    @w_queen = "\u2655 "
    @w_rook = "\u2656 "
    @w_bishop = "\u2657 "
    @w_knight = "\u2658 "

  end

  def assing_blacks
    @b_pawn = "\u265F "
    @b_king = "\u265A "
    @b_queen = "\u265B "
    @b_rook = "\u265C "
    @b_bishop = "\u265D "
    @b_knight = "\u265E "
  end

  def place_pieces
    i = 1
    while i<9 #places b&w pawns
      @board[2][i] = @w_pawn
      @board[7][i] = @b_pawn
      i += 1
    end

    @board[1][5] = @w_king #places kings
    @board[8][5] = @b_king #

    @board[1][1] = @w_rook #places rooks
    @board[1][8] = @w_rook #
    @board[8][1] = @b_rook #
    @board[8][8] = @b_rook #

    @board[1][2] = @w_knight #places knights
    @board[1][7] = @w_knight # 
    @board[8][2] = @b_knight # 
    @board[8][7] = @b_knight # 

    @board[1][3] = @w_bishop #places bishops
    @board[1][6] = @w_bishop #
    @board[8][3] = @b_bishop #
    @board[8][6] = @b_bishop #

    @board[1][4] = @w_queen#places queens
    @board[8][4] = @b_queen#
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

