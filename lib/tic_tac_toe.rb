# Defining WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # left column
  [1,4,7], # middle column
  [2,5,8], # right column
  [0,4,8], # diagonal 1
  [2,4,6] # diagonal 2
]

#Defining the display board
def display_board(board=[" "," "," "," "," "," "," "," "," "])
  def dash
    puts "-----------"
  end
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  dash
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  dash
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Converting user input to index
def input_to_index(user_input)
  user_input.to_i - 1
end

#Defining the move to fill the board with character
def move(board, index, character)
  board[index] = character
end

#Defining if the position to be occupied if filled or empty
def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

#Checks if the move requested is valid or not
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

#Fills in the move requested by the player on the board
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  character = current_player(board)
  if valid_move?(board, index)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end

#Counts the number of turns carried out by counting filled positions
def turn_count(board)
  turns = 0
  board.each do |x|
    if x != " "
      turns+=1
    end
  end
  turns
end

#Determines the current character by judging the number of plays made
def current_player(board)
  turns = turn_count(board)
  if turns.odd?
    return "O"
  else
    return "X"
  end
end

#define a method to check for winning combinations
def won?(board)
  win_combo = nil
  WIN_COMBINATIONS.each do |win_combination|
#    win_index_1 = win_combination[0] alternative method to do using variable assign
#    win_index_2 = win_combination[1]
#    win_index_3 = win_combination[2]
    position_1 = board[win_combination[0]] # load the value of the board at win_index_1
    position_2 = board[win_combination[1]] # load the value of the board at win_index_2
    position_3 = board[win_combination[2]] # load the value of the board at win_index_3
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      win_combo = win_combination # return the win_combination indexes that won.
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      win_combo = win_combination
    end
  end
  win_combo
end

#Checks if the board is full or not
def full?(board)
  board.all? {|x| x != " "}
end

#Checks if the board is draw
def draw?(board)
  if won?(board) == nil && full?(board) == true
    return true
  end
end

#Checks if the game is over
def over?(board)
  if won?(board) != nil || draw?(board) == true || full?(board) == true
    return true
  end
end

#Determines the winner character
def winner(board)
  token = nil
  if won?(board) != nil
    win_combo = won?(board)
    token = board[win_combo[0]]
  end
  token
end

#Defines the play method
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
