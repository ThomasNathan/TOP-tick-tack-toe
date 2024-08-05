require_relative ("game.rb")
require_relative ("board.rb")
require 'pry'

class TakeTurn < Board
  attr_accessor :player1, :player2, :board

  def initialize
    @player1 = "Player 1"
    @player2 = "Player 2"
    @board = Board.new
    @current_player = @player1
  end

  def taking_turns
    puts "**********TICK * TACK * TOE**********"
    10.times { puts "*" }

    until @board.game_over?
      @board.print_board
      player_choice(@current_player)
    end
    @board.print_board
    if @board.winner?

      puts "Game over! #{@current_player} wins!"
      exit
    else
      puts "Game over! It's a tie!"
      exit
    end
  end

  def player_choice(player)
    puts "#{player}: Enter the coordinates of your selection."
    choice = gets.chomp.downcase.gsub(/[[:space:]]/, "")

    unless valid_choice?(choice)
      puts "Please enter a valid choice."
      choice = nil
      player_choice(@current_player)
    else
      puts "#{choice} is a great choice!"
      mark_board(choice)
      choice = nil
    end
  end

  def change_player
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def valid_choice?(choice)
    valid_choices = ["a1", "a2", "a3", "b1", "b2", "b3", "c1", "c2", "c3"]

    valid_choices.include?(choice) && empty_space?(@board.coordinate_keys(choice))
  end

  def mark_board(choice)
    if @current_player == @player1
      player = "X"
    else
      player = "O"
    end

    case choice
    when "a1"
      @board.a1 = player
    when "a2"
      @board.a2 = player
    when "a3"
      @board.a3 = player
    when "b1"
      @board.b1 = player
    when "b2"
      @board.b2 = player
    when "b3"
      @board.b3 = player
    when "c1"
      @board.c1 = player
    when "c2"
      @board.c2 = player
    when "c3"
      @board.c3 = player
    else
      puts "Invalid choice."
    end
    change_player
  end
end

t = TakeTurn.new

t.taking_turns
