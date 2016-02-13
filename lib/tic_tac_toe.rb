#All possible winning combinations
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6], #left column
  [1,4,7],  #Middle column
  [2,5,8], # Right column
  [0,4,8],  # Diagnol 1
  [2,4,6]   # Diagnol 2
]
#Accepting a location between 1-9 and map the location on to
#the corresponding index from 0-8
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Accepting a board and location, and current player, and modify the board
def move(board, move, current_player = "X")
  board[move.to_i-1] = current_player
end

#check if a position on the board is taken or not. Called by the valid_move?method
def position_taken?(board, move)
  !(board[move].nil? || board[move] == " ")
end

#check if a move made by the player is valid or not
def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

#the function for a full turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
    display_board(board)
  else
    puts "Invalid move."
    turn(board)
  end
end

#return the count of current turn
def turn_count(board)
  count = 0
  for position in board
    if position == "X" || position == "O"
      count += 1
    end
  end
  return count
end

#Take the board as input and return the current player
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  for winning_combination in WIN_COMBINATIONS
    if position_taken?(board, winning_combination[0])
      if board[winning_combination[0]] == board[winning_combination[1]] && board[winning_combination[1]] == board[winning_combination[2]]
        return winning_combination
      end
    end
  end
  return false
end

def full?(board)
  for position in board
    unless position == "X" || position == "O"
      return false
    end
  end
  return true
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  end
  return false
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end


def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end

