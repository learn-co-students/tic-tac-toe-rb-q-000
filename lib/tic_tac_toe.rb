# Define WIN_COMBINATIONS constant

 WIN_COMBINATIONS = [
   [0,1,2],
   [3,4,5],
   [6,7,8],
   [0,4,8],
   [2,4,6],
   [0,3,6],
   [1,4,7],
   [2,5,8]
 ]


 # DISPLAY_BOARD that accepts a board and prints
 # out the current state.

 def display_board(board)
   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
   puts " #{board[3]} | #{board[4]} | #{board[5]} "
   puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


# INPUT_TO_INDEX has one argument and converts user_input to an integer

 def input_to_index(user_input)
      user_input = user_input.to_i - 1
end


# MOVE moves the "X" or "O" to a certin position takes three argements one of
# type of array another of type integer and the last of type string

 def move(array,index, player)
   array[index] = player
end


# POSITION_TAKEN? checks to see if a position is taken one of type of array and
# and another of type integer

 def position_taken?(board, location)
   !(board[location]  == " " || board[location].nil?)
end


# VALID_MOVE? it takes two arguments and checks the range one of type array and
# and another argument of type integer

 def valid_move?(board,index)
   if !(position_taken?(board,index)) && index.between?(0,8)
     return true
   else
     return false
   end
 end


# TURN it takes a argument of type array and checks to see if the input is
# valid

 def turn(board)
   puts "Please enter 1-9:"
   input = gets.strip
   index = input_to_index(input)
   if valid_move?(board, index)
     move(board, index, current_player(board))
     display_board(board)
   else
     turn(board)
   end
 end

# TURN_COUNT takes an argument of type array  and checks to see if the position
# was taken

 def turn_count(board)
   board.count{|took| took == "X" || took == "O"}
 end

#CURRENT_PLAYER takes in an argument of type array or board and alternates between
# X and O

def current_player(board)
    if turn_count(board) % 2 == 0
      return "X"
    else
      return "O"
    end
  end

# WON? grabs each index from the WIN_COMBINATIONS that composes a win
# Takes an array type called board and returns a wining position

  def won?(board)
    WIN_COMBINATIONS.find do |win_combination|
    board_combination = [board[win_combination[0]], board[win_combination[1]], board[win_combination[2]]]
    board_combination.join == "XXX" || board_combination.join == "OOO"
  end
end



  #Full? method accept's a board or an array and return true if every element in
  #in board contains either "X" or "O"

  def full?(board)
  index = [0,1,2,3,4,5,6,8]
  index.all? {|i| position_taken?(board, i)}
  end

  #DARW? that accepts a board and returns true if the board has not been won and
  # and is full and false if the board is not won and not full, and false and
  # if it is a  winning board

   def draw?(board)
    if  !(won?(board)) && full?(board)
      true
    else
      false
    end
   end

  #OVER? accepts a board and returns true if the board has been won, and full
  #returns false if the board is a draw

  def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
  end

  #WINNER method should accept a board or array  and return the token "X" or "O" that has won
  #the game given a winning board

  def winner(board)
    board_return = won?(board)
    if board_return.class == Array
      if board[board_return[0]] == "X"
        return "X"
      else
        return "O"
      end
    else
      return nil
    end
  end

#this is how the game is played 
  def play(board)
    until over?(board)
      turn(board)
    end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
