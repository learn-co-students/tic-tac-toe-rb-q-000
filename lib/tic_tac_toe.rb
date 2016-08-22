# WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], #top row win
  [3, 4, 5], #middle row win
  [6, 7, 8], #bottom row win
  [0, 3, 6], #top left-bottom win
  [1, 4, 7], #middle-bottom win
  [2, 5, 8], #top right-bottom win
  [0, 4, 8], #top left-bottom right win
  [2, 4, 6] #top right-bottom left win
]

# Tic-Tac_Toe board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Input subtracts 1 for 1-9
def input_to_index(user_input)
  user_input.to_i - 1
end

# Move on board
def move( board, index, current_player )
  board[index] = current_player
end

# Method see if position is already taken
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

# Method is input valid move on board
def valid_move?(board, index)
  if index.between?(0,8) && !position_taken?(board, index)
    return true
  else
    false
end
end

# Make turn method
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


# Number of turns played
def turn_count(board)
  counter = 0
  board.each do |box|
    if box == "X" || box == "O"
  counter += 1
end
end
  return counter
end

# Current player method
def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
end
end

# Check if there is a winner method
def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    if (board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X") || (board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O")
      return win_combo
    end
  end
  return false
end

#Checks if board is full- ternary syntax
def full?(board)
  board.all? {|full| full != " "} ? true : false
end

#Checks if the match is a draw
def draw?(board)
  if !won?(board) && full?(board)
    return true
  if !won?(board) && !full?(board) && won?(board)
    return false
  end
end
end

# Checks if match is over
def over?(board)
  if draw?(board) || full?(board) || won?(board)
    return true
  else
    false
  end
end

# Checks for winner
def winner(board)
  return nil if !won?(board)

  position = won?(board)[0]
    if board[position] == "X"
      return "X"
    elsif board[position] == "O"
      return "O"
  end
end

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
