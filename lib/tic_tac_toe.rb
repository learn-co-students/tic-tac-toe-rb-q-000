# defines a constant with arrays for each win combination
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

# display board prints arbitrary arrangements of the board
def display_board(board)
  #puts "Welcome To Tic Tac Toe"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

#move allows "X" player in the bottom right and "O" in the top left
def move(board, input, char = "X")
  board[input.to_i-1] = char
end

#position_taken? returns true/false based on position in board
def position_taken?(board, int)
  if board[int] == "X" || board[int] == "O"
    true
  elsif board[int] == " " || board[int] == ""
    false
  elsif board[int] == nil
    false
  end
end

#valid_move? returns true/false based on position
def valid_move?(board, position)
  position = position.to_i - 1
  if position.between?(0, 8) == true && position_taken?(board, position) == false
    true
  end
end

#turn makes valid moves asks for input again after a failed validation
def turn(board)
  puts "Please enter 1-9:"
  square = gets.chomp
  if valid_move?(board, square)
    move(board, square, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

#turn_count counts occupied positions
def turn_count(board)
count = 0
  board.each do |i|
    if i == "X" || i == "O"
      count += 1
    end
  end
  return count
end

#current_player returns the correct player, X, for the third move
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  # First, let's make a local variable that is going
  # to be the return value of this method.
  winning_combination = nil

  # Check to see if anyone has won
  WIN_COMBINATIONS.each do |combo|
    first_position = board[combo[0]]
    second_position = board[combo[1]]
    third_position = board[combo[2]]

    if first_position == "X" && second_position == "X" && third_position == "X"
      winning_combination = combo
    elsif first_position == "O" && second_position == "O" && third_position == "O"
      winning_combination = combo
    end
  end

  # Then no matter what we return winning_combination
  # it'll either still be nil if no one has won
  # or it will be the winning_combo we set in the middle
  return winning_combination
end

# Is the board full?
def full?(board)
  if board.any?{|i| i == " "}
    return false
  else
    true
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  elsif !won?(board) && !full?(board)
    return false
  elsif won?(board)
    false
  end
end

# Define game over
def over?(board)
  if draw?(board) || won?(board) || full?(board)
    return true
  else
    return false
  end
end

# Define winner
def winner(board)
  if win_array = won?(board)
    return board[win_array[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end