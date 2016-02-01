# define a constant for win combinations
WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #left column
  [1, 4, 7], #middle column
  [2, 5, 8], #right column
  [0, 4, 8], #down diagonal
  [6, 4, 2]  #up diagonal
]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts "Welcome To Tic Tac Toe"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

# code your move method here!
def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

# code your #position_taken? method here!
def position_taken?(board, int)
  if board[int] == "X" || board[int] == "O"
    true
  elsif board[int] == " " || board[int] == ""
    false
  elsif board[int] == nil
    false
  end
end

# code your #valid_move? method here
def valid_move?(board, position)
  position = position.to_i - 1
  if position.between?(0, 8) == true && position_taken?(board, position) == false
    true
  end
end

# Define turn
def turn(board)
  puts "Please enter 1-9:"
  square = gets.chomp
  if valid_move?(board, square)
    move(board, square)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
count = 0
  board.each do |place|
    if place == "X" || place == "O"
      count+= 1
    end
  end
  return count
end

# Current player
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

# Discover if a win can be matched
def win?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination # return the win_combination indexes that won.
    else
      false
    end
  end
end

# Find a draw
def draw?(board)
  if win?(board) == [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2]] && full?(board)
    return true
  elsif win?(board) == [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2]] && !full?(board)
    return false
  else
    false
  end
end

# Is the board empty?
def empty?(board)
  if board.any?{|i| i != " "}
    false
  else
    true
  end
end

# Define won
def won?(board)
  if empty?(board) == true
    return false
  elsif draw?(board) == true
    return false
  elsif win?(board)
    return win?(board)
  else
    return false
  end
end

# Is the board full?
def full?(board)
  if board.any?{|i| i == " "}
    return false
  else
    true
  end
end

# Define game over
def over?(board)
  if won?(board) != [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2]]
    return true
  elsif draw?(board) == true
    return true
  elsif full?(board) == true
    return true
  else
    false
  end
end

# Define winner
def winner(board)
  if won?(board) != [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2]]
  win_array = won?(board)
    if board[win_array[0]] == "X"
      return "X"
    else
      return "O"
    end
  else
    return
  end
end

# Define your play method below
def play(board)
count = 0
  while count < 9
    turn(board)
    count += 1
  end
end