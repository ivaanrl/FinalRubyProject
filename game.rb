require_relative 'board'

class Game
  def initialize
    @board = Board.new
    @turn = 'white'
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
    else 
      puts "how many times do you go here?!"
      @board.chosen_error
    end
    @board.check?(@turn)
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
    return false
  end
end

game = Game.new