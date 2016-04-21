# constant for winning combinations
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6], # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right column
  [0,4,8],  # Diagonal 1
  [6,4,2]  # Diagonal 2
]


# prints out the current state of the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


# mothod to take player's input and add it to the board
def move(board, input, value = "X")
  board[input.to_i - 1] = value
end


# check if the position the player took is taken
def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  elsif board[position] == "X" || board[position] == "O"
    true
  end
end


# check if player's move is valid
def valid_move?(board, position)
  if position.to_i.between?(0, 10)
    if position_taken?(board, position.to_i)
      false
    else
      true
    end
  else 
    false
  end
end


# asks the user for their turn, display board if valid
def turn(board)
  puts "Please enter 1-9:"
  position = gets.chomp

  while !valid_move?(board, position)
    puts "Please enter 1-9:"
    position = gets.chomp
  end

  move(board, position, "X")

  display_board(board)
end


#   takes in an argument of the board array and returns the number of turns that have been played.
def turn_count(board)
  count = 0
  board.each do |board_item|
    if board_item != " "
      count += 1
    end
  end
  count
end


#  check who's turn it is
def current_player
end


# determines if there is a winner
def won?(board)
  WIN_COMBINATIONS.each do |combination|
    win_index_1 = combination[0]
    win_index_2 = combination[1]
    win_index_3 = combination[2]
   
    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3
  
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return combination # return the win_combination indexes that won.
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return combination # return the win_combination indexes that won.
    end
  end
  false
end


# determines if the board is full or not
def full?(board)
  if board.include?(" ")
    false
  else
    true
  end
end


# determines if there is a tie
def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end


# determines if the game is over
def over?(board)
  if draw?(board) || won?(board)
    true
  else 
    false
  end
end


# returns the winning token
def winner(board)
  if won?(board)
    win_array = won?(board)
    position = win_array[0]
    board[position]
  else 
    nil
  end
end






