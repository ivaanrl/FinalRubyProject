require_relative 'piece'
require_relative 'bishop'
require_relative 'pawn'
require_relative 'queen'
require_relative 'king'
require_relative 'knight'
require_relative 'rook'

class Board
  attr_accessor :board, :chosen_error

  def initialize
    @board = Array.new(9) {Array.new(9)}
    @chosen = ''
    assing_pieces
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
    @w_rook1 = Rook.new("white")
    @w_rook2 = Rook.new('white')
    @w_bishop1 = Bishop.new("white")
    @w_bishop2 = Bishop.new("white")
    @w_knight1 = Knight.new("white")
    @w_knight2 = Knight.new("white")
  end

  def assing_blacks
    @b_pawn = Array.new(8,Pawn.new('black'))
    @b_king = King.new('black')
    @b_queen = Queen.new('b')
    @b_rook1 = Rook.new('b')
    @b_rook2 = Rook.new('b')
    @b_bishop1 = Bishop.new('b')
    @b_bishop2 = Bishop.new('b')
    @b_knight1 = Knight.new('b')
    @b_knight2 = Knight.new('b')
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

    @board[1][1] = @b_rook1.piece #places rooks
    @board[1][8] = @b_rook2.piece #
    @board[8][1] = @w_rook1.piece #
    @board[8][8] = @w_rook2.piece #

    @board[1][2] = @b_knight1.piece #places knights
    @board[1][7] = @b_knight2.piece # 
    @board[8][2] = @w_knight1.piece # 
    @board[8][7] = @w_knight2.piece # 

    @board[1][3] = @b_bishop1.piece #places bishops
    @board[1][6] = @b_bishop2.piece #
    @board[8][3] = @w_bishop1.piece #
    @board[8][6] = @w_bishop2.piece #

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
    label = 1
    for i in 1..8 do
      @board[0][i] = ' ' + label.to_s
      label = label.next
      @board[i][0] = i
    end
  end

  def move_white(initial_row, initial_column, target_row, target_column, turn)
    valid = false

    case @board[initial_row.to_i][initial_column.to_i]
    when "\u265A "
      @chosen_error = King.error
      taken = square_taken?(target_row, target_column)
      valid = @w_king.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn)
    when "\u265B "
      taken = square_taken?(target_row, target_column)
      if path_empty_col([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i]) ||
        path_empty_row([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i]) ||
        path_empty_diagonal?([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i])
           valid = @w_queen.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn)
      end
    when "\u265C "
      taken = square_taken?(target_row, target_column)
      @chosen_error = Rook.error
      if path_empty_col([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i]) || 
        path_empty_row([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i])
       valid = @w_rook1.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn) ||
               @w_rook2.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn)
      end
    when "\u265D "
      taken = square_taken?(target_row, target_column)
      @chosen_error = Bishop.error
      if path_empty_diagonal?([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i])
        valid = @w_bishop1.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn) ||
                @w_bishop2.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn)
      end
    when "\u265E "
      taken = square_taken?(target_row, target_column)
      @chosen_error = Knight.error
      valid = @w_knight1.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn) || 
              @w_knight2.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn)
    when "\u265F "
      taken = square_taken?(target_row, target_column)
      valid = Pawn.move([initial_row.to_i, initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn)
    end
    valid
  end

  def check_whites?(king_row, king_col, turn)
    if move_white(@w_queen.position[0], @w_queen.position[1], king_row, king_col, turn) || 
       move_white(@w_rook1.position[0], @w_rook1.position[1], king_row, king_col, turn) ||
       move_white(@w_rook2.position[0], @w_rook2.position[1], king_row, king_col, turn) ||
       move_white(@w_bishop1.position[0], @w_bishop1.position[1], king_row, king_col, turn) ||
       move_white(@w_bishop2.position[0], @w_bishop2.position[1], king_row, king_col, turn) ||
       move_white(@w_knight1.position[0], @w_knight1.position[1], king_row, king_col, turn) ||
       move_white(@w_knight2.position[0], @w_knight2.position[1], king_row, king_col, turn)
         return true
    else
      return false
    end
  end

  def check_blacks?(king_row, king_col, turn)
    if move_black(@b_queen.position[0], @b_queen.position[1], king_row, king_col, turn) || 
       move_black(@b_rook1.position[0], @b_rook1.position[1], king_row, king_col, turn) ||
       move_black(@b_rook2.position[0], @b_rook2.position[1], king_row, king_col, turn) ||
       move_black(@b_bishop1.position[0], @b_bishop1.position[1], king_row, king_col, turn) ||
       move_black(@b_bishop2.position[0], @b_bishop2.position[1], king_row, king_col, turn) ||
       move_black(@b_knight1.position[0], @b_knight1.position[1], king_row, king_col, turn) ||
       move_black(@b_knight2.position[0], @b_knight2.position[1], king_row, king_col, turn)
        return true
    else
      return false
    end
  end

  def king_possible_moves(turn)

    if turn == 'white'
      posible_moves = [[@b_king.position[0],@b_king.position[1]]]
      if move_white(@b_king.position[0], @b_king.position[1], @b_king.position[0] + 1, @b_king.position[0] + 1, 'white')
        posible_moves.push([b_king.position[0] + 1, b_king.position[0] + 1])
      end
      if move_white(@b_king.position[0], @b_king.position[1], @b_king.position[0] + 1, @b_king.position[0] - 1, 'white')
        posible_moves.push([b_king.position[0] + 1, b_king.position[0] - 1])
      end
      if move_white(@b_king.position[0], @b_king.position[1], @b_king.position[0] - 1, @b_king.position[0] + 1, 'white')
        posible_moves.push([b_king.position[0] - 1, b_king.position[0] + 1])
      end
      if move_white(@b_king.position[0], @b_king.position[1], @b_king.position[0] - 1, @b_king.position[0] - 1, 'white')
        posible_moves.push([b_king.position[0] - 1, b_king.position[0] - 1])
      end
      if move_white(@b_king.position[0], @b_king.position[1], @b_king.position[0], @b_king.position[0] + 1, 'white')
        posible_moves.push([b_king.position[0] + 1, b_king.position[0] + 1])
      end
      if move_white(@b_king.position[0], @b_king.position[1], @b_king.position[0] + 1, @b_king.position[0], 'white')
        posible_moves.push([b_king.position[0] + 1, b_king.position[0] - 1])
      end
      if move_white(@b_king.position[0], @b_king.position[1], @b_king.position[0] - 1, @b_king.position[0], 'white')
        posible_moves.push([b_king.position[0] - 1, b_king.position[0] + 1])
      end
      if move_white(@b_king.position[0], @b_king.position[1], @b_king.position[0], @b_king.position[0] - 1, 'white')
        posible_moves.push([b_king.position[0] - 1, b_king.position[0] - 1])
      end
    else
      posible_moves = [[@w_king.position[0],@w_king.position[1]]]
      if move_black(@w_king.position[0], @w_king.position[1], @w_king.position[0] + 1, @w_king.position[0] + 1, 'white')
        posible_moves.push([b_king.position[0] + 1, b_king.position[0] + 1])
      end
      if move_black(@w_king.position[0], @w_king.position[1], @w_king.position[0] + 1, @w_king.position[0] - 1, 'white')
        posible_moves.push([b_king.position[0] + 1, b_king.position[0] - 1])
      end
      if move_black(@w_king.position[0], @w_king.position[1], @w_king.position[0] - 1, @w_king.position[0] + 1, 'white')
        posible_moves.push([b_king.position[0] - 1, b_king.position[0] + 1])
      end
      if move_black(@w_king.position[0], @w_king.position[1], @w_king.position[0] - 1, @w_king.position[0] - 1, 'white')
        posible_moves.push([b_king.position[0] - 1, b_king.position[0] - 1])
      end
      if move_black(@w_king.position[0], @w_king.position[1], @w_king.position[0] + 1, @w_king.position[0], 'white')
        posible_moves.push([b_king.position[0] + 1, b_king.position[0] + 1])
      end
      if move_black(@w_king.position[0], @w_king.position[1], @w_king.position[0], @w_king.position[0] - 1, 'white')
        posible_moves.push([b_king.position[0] + 1, b_king.position[0] - 1])
      end
      if move_black(@w_king.position[0], @w_king.position[1], @w_king.position[0], @w_king.position[0 + 1], 'white')
        posible_moves.push([b_king.position[0] - 1, b_king.position[0] + 1])
      end
      if move_black(@w_king.position[0], @w_king.position[1], @w_king.position[0] - 1, @w_king.position[0], 'white')
        posible_moves.push([b_king.position[0] - 1, b_king.position[0] - 1])
      end
    end
    posible_moves
  end

  def move_black(initial_row, initial_column, target_row, target_column, turn)
    valid = false
    case @board[initial_row.to_i][initial_column.to_i]
    when "\u2654 "
      taken = square_taken?(target_row, target_column)
      @chosen_error = King.error
      valid = @b_king.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn)
    when "\u2655 "
      taken = square_taken?(target_row, target_column)
      if path_empty_col([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i]) ||
         path_empty_row([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i]) ||
         path_empty_diagonal?([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i])
            valid = @b_queen.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn)
      end
    when "\u2656 "
      taken = square_taken?(target_row, target_column)
      @chosen_error = Rook.error
      if path_empty_col([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i]) || 
         path_empty_row([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i])
          valid = @b_rook1.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn) ||
                  @b_rook2.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn)
      end
    when "\u2657 "
      taken = square_taken?(target_row, target_column)
      @chosen_error = Bishop.error
      if path_empty_diagonal?([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i])
        valid = @b_bishop1.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn) ||
                @b_bishop2.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn)
      end
    when "\u2658 "
      taken = square_taken?(target_row, target_column)
      @chosen_error = Knight.error
      valid = @b_knight1.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn) ||
              @b_knight2.move([initial_row.to_i,initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn)
    when "\u2659 "
      taken = square_taken?(target_row, target_column)
      valid = Pawn.move([initial_row.to_i, initial_column.to_i], [target_row.to_i, target_column.to_i], taken, turn)
    end
    valid
  end

  def path_empty_diagonal?(initial_square, target_square)
    i = 1
    moves = initial_square[0] < target_square[0] ? target_square[0] - initial_square[0] : initial_square[0] - target_square[0]
    if (initial_square[0] + moves == target_square[0] && initial_square[1] + moves == target_square[1])
      while i < moves
        if @board[initial_square[0] + i][initial_square[1] + i] != @empty
          puts "There's a piece in the way. Please enter a new set of coordinates."
          return false
        end
        i += 1
      end
    elsif (initial_square[0] - moves == target_square[0] && initial_square[1] - moves == target_square[1])
      while i < moves
        if @board[initial_square[0] - i][initial_square[1] - i] != @empty
          puts "There's a piece in the way. Please enter a new set of coordinates."
          return false
        end
        i += 1
      end
    elsif (initial_square[0] - moves == target_square[0] && initial_square[1] + moves == target_square[1])
      while i < moves
        if @board[initial_square[0] - i][initial_square[1] + i] != @empty
          puts "There's a piece in the way. Please enter a new set of coordinates."
          return false
        end
        i += 1
      end
    elsif (initial_square[0] + moves == target_square[0] && initial_square[1] - moves == target_square[1])
      while i < moves
        if @board[initial_square[0] + i][initial_square[1] - i] != @empty
          puts "There's a piece in the way. Please enter a new set of coordinates."
          return false
        end
        i += 1
      end
    else
      return false
    end
    true
  end

  def path_empty_col(initial_square, target_square)
    i = 1
    moves = initial_square[0] < target_square[0] ? target_square[0] - initial_square[0] : initial_square[0] - target_square[0]
    if initial_square[0] + moves == target_square[0] && initial_square[1] == target_square[1]
      while i < moves 
        if @board[initial_square[0] + i][initial_square[1]] != @empty
          puts "There's a piece in the way. Please enter a new set of coordinates."
          return false
        end
        i += 1
      end
    elsif initial_square[0] - moves == target_square[0] && initial_square[1] == target_square[1]
      while i < moves
        if @board[initial_square[0] - i][initial_square[1]] !=@empty
          puts "There's a piece in the way. Please enter a new set of coordinates."
          return false
        end
        i += 1
      end
    else
      return false
    end
    true 
  end

  def path_empty_row(initial_square, target_square)
    i = 1
    moves = initial_square[1] < target_square[1] ? target_square[1] - initial_square[1] : initial_square[1] - target_square[1]
    if initial_square[0] == target_square[0] && initial_square[1] + moves == target_square[1]
      while i < moves 
        if @board[initial_square[0]][initial_square[1] + i] != @empty
          puts "There's a piece in the way. Please enter a new set of coordinates."
          return false
        end
        i += 1
      end
    elsif initial_square[0] == target_square[0] && initial_square[1] - moves == target_square[1]
      while i < moves
        if @board[initial_square[0]][initial_square[1] - i] !=@empty
          puts "There's a piece in the way. Please enter a new set of coordinates."
          return false
        end
        i += 1
      end
    else
      return false
    end
    true 
  end

  def square_taken?(target_row, target_column)
    square = []
    square.push(@board[target_row.to_i][target_column.to_i] == "\u25A1 " ? false : true)
    square.push(is_white?(@board[target_row.to_i][target_column.to_i]))
  end

  def is_white?(board_square)
    case board_square
    when "\u265A ", "\u265B ", "\u265C ", "\u265D ", "\u265E ", "\u265F "
      return 'white'
    else 
      return 'black'
    end
  end

  def move_piece(initial_row, initial_column, target_row, target_column, turn)
    @board[target_row.to_i][target_column.to_i] = @board[initial_row.to_i][initial_column.to_i]
    @board[initial_row.to_i][initial_column.to_i] = "\u25A1 "
    display_board
  end

  def display_board
    puts
    puts @board.reverse.map { |row| row.map { |value| ' ' + value.to_s + ' '}.join}
    puts "\n"
  end
end

w = Board.new

