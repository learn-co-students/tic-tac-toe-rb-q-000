
# Winning combination constant
WIN_COMBINATIONS = [
  [0,1,2], # top win
  [3,4,5], # middle win
  [6,7,8], # bottom win
  [0,3,6], # left win
  [1,4,7], # center win
  [2,5,8], # right win
  [0,4,8], # left diagonal win
  [2,4,6]  # right diagonal win
  ]

# Display the board
board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Make a move
def move(board, position, player = "X")
  position = position.to_i
  position = position - 1

  board[position] = player
end

# Check if a position selected has already been taken
def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  elsif board[position] == "X" || board[position] == "O"
    true
  end
end

# Check if a move is valid
def valid_move?(board, position)
  position = position.to_i
  position = position - 1

  if position.between?(0,8)
    final_outcome = position_taken?(board, position)
    !final_outcome
   else
    false
  end
end

# Take a turn
def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip

  is_valid_move = valid_move?(board, position)

  if is_valid_move
    player = current_player(board)
    move(board, position, player)
    display_board(board)
  else
    turn(board)
  end
end

# How many turns have been taken
def turn_count(board)
  turns_taken = []
  turns_taken = board.select{|i| i != " "}
  turns_taken.length
end

# Determine who's turn it is
def current_player(board)
  turns_taken = turn_count(board)

  if turns_taken % 2 == 0
    "X"
  else
    "O"
  end
end

# Determine if someone has won the game
def won?(board)
  counter = 0
  winning_combo = false
  WIN_COMBINATIONS.each do |win_combination|
    counter += 1

    win_index1 = win_combination[0]
    win_index2 = win_combination[1]
    win_index3 = win_combination[2]

    position1 = board[win_index1]
    position2 = board[win_index2]
    position3 = board[win_index3]

   if (position1 == "X" && position2 == "X" && position3 == "X") ||
        (position1 == "O" && position2 == "O" && position3 == "O")
      winning_combo = win_combination
    end
  end

  return winning_combo

end

# Game board is full
def full?(board)
  all_full = board.all? do |character|
    character == "X" || character == "O"
  end
end

# Game is a draw
def draw?(board)
  # returns true if the board has not been won and is full
  # return false if the board is not won and the board is not full
  # return false if the board is won

  if !won?(board) && full?(board)
    true
  elsif !won?(board) && !full?(board)
    false
  elsif won?(board)
    false
  end
end

# Game over?
def over?(board)
  # returns true if the board has been won, is a draw, or is full
  if won?(board) || draw?(board) || full?(board)
    true
  end
end

# Did someone win?
def winner(board)
  winning_number = won?(board)

  if !winning_number
    nil
  else
    board[winning_number[0]]
  end

end

# Game looping method
def play(board)
  until over?(board)
    #input = turn(board)
    turn(board)
  end

  if won?(board)
    winning_player = winner(board)
    puts "Congratulations #{winning_player}!"
  else
    puts "Cats Game!"
  end
end
