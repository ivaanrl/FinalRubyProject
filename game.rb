require_relative 'board'

class Game
  def initialize
    @turn = 'white'
    @board = Board.new
    welcome_message
    start_game
  end

  def welcome_message
    puts "You are about to start a game of chess."
    puts "Do you want to load a previous match or start a new game?"
    #choice = gets.chomp
    #load_or_new
  end

  def start_game
    puts "White starts. this is the board now: "
    @board.display_board
    while !game_over
      play
    end
  end

  def play
    puts "It's #{@turn} turn, what move do you want to do?"
    puts "Enter initial row: "
    initial_row = gets.chomp
    puts "enter initial column: "
    initial_column = gets.chomp
    puts "enter target row: "
    target_row = gets.chomp
    puts "enter target column: "
    target_column = gets.chomp
    if valid_move?(initial_row, initial_column, target_row, target_column, @turn)
      @board.move_piece(initial_row, initial_column, target_row, target_column, @turn)
      @turn == 'white' ? @turn = 'black' : @turn = 'white'
    else 
      @board.chosen_error
    end
  end

  def valid_move?(initial_row, initial_column, target_row, target_column, turn)
    if initial_row.to_i.between?(1,8) && initial_column.to_i.between?(1,8) && target_row.to_i.between?(1,8) && target_column.to_i.between?(1,8)
      if turn == 'white'
        valid = @board.move_white(initial_row, initial_column, target_row, target_column, turn)
        if valid
          return true
        else
          play
        end
      else
        valid = @board.move_black(initial_row, initial_column, target_row, target_column, turn)
        if valid
          return true
        else
          play
        end
      end
    else 
      puts "Those aren't valid coordinates. Please choose them again."
      play
    end
  end

  def game_over
    if @turn == 'white'
      possible_moves = @board.king_possible_moves(@turn)
     if possible_moves.all? { |position| @board.check_whites?(position[0], position[1], @turn)}
       puts "###################"
       puts "CHECK MATE. WHITE WINS."
       puts "###################"
       return true
     end
      if possible_moves.any? { |position| @board.check_whites?(position[0], position[1], @turn)}
        puts "###############"
        puts "Black king is in check."
        puts "############"
      end
    else
      possible_moves = @board.king_possible_moves(@turn)
      if possible_moves.all? {|position| @board.check_blacks?(position[0], position[1], @turn)}
        puts "###################"
        puts "CHECK MATE. BLACK WINS."
        puts "###################"
        return true
      end
      if possible_moves.any? { |position| @board.check_blacks?(position[0], position[1], @turn)}
        puts "###############"
        puts "White king is in check."
        puts "############"
      end
    end
    return false

  end
end

game = Game.new