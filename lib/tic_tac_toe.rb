# Helper Methods
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

#play the game until someone wins or board is full with no winner
def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
enddef position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Left column
  [0,4,8],  # Diagonal 1
  [2,4,6]   # Diagonal 2
]

def won?(board)
  #check for empty board first
  if (board.detect { |e| e=="X" || e=="O" }) == nil then return false
  end

  #otherwise check for winning combinations
  WIN_COMBINATIONS.each do |combo|

    if (board[combo[0]]== "X" && board[combo[1]] == "X" && board[combo[2]]== "X") ||
    (board[combo[0]]== "O" && board[combo[1]] == "O" && board[combo[2]]== "O") then return combo
    end
  end
  return false
end

# check for a full board, all spots used
def full?(board)
  board.all?{|a| (a=="X" || a== "O")}
end

# check for a draw if board is full and no winner
def draw?(board)
  if !won?(board) && full?(board)  then return true
  end
end

# check if the game is over
def over?(board)
  #if full?(board) || won?(board) || draw?(board) then return true
  if won?(board) || draw?(board) then return true
  else return false
  end
end

# check on X or O as winner and return "X" or "O"
def winner(board)
  if won?(board) then return board[won?(board)[0]]
  end
end

# find out how many turns have been played
# by counting the number of "X" or "O" spaces on the board
def turn_count(board)
  counter = 0
  board.each {|char|
    if char == "O" || char == "X"
      counter += 1
    end
  }
  return counter
end

# determine the current player
def current_player(board)
  return turn_count(board).odd? ? "O" : "X"

end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  token = turn_count(board).odd? ? "O" : "X"
  if valid_move?(board, index)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

#Define your play method below
def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
     puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
     puts "Cats Game!"
  end
end
