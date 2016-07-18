# This arrray represents all the possible combinations of positions to be filled on the board that possibly constitute a victory for either side
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left column
  [1,4,7], #middle column
  [2,5,8], #right column
  [0,4,8], #top left to bottom right diagonal
  [2,4,6]  #bottom left to top right diagonal
]

# Provides an ASCII representation of the board using the board array.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Converts user input to an index number used to access data in the board array.
def input_to_index(user_input)
  user_input.to_i - 1
end

# Puts an "X" or an "O" on the board at the position designated by index.
def move(board, index, current_player)
  board[index] = current_player
end

# Returns true of the given position has an "X" or "O" in it or false if it doesn't have either. Takes a value that has been converted to an index.
def position_taken?(board, index)
  index = index.to_i
  !(board[index].nil? || board[index] == " ")
end

# Checks to see if the given move designated by the given index value is taken by checking the index is a valid integer 0-8 and the position has not been taken.
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# Composes of one full move by askuing for user input, converting it to an index, validating the move, and displaying the resulting board. Will loop until a valid move has been input.
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

# Returns the number of completed turns that have passed by counting the number of positions that are taken.
def turn_count(board)
  count = 0
  index = 0
  while (index < 9)
    if position_taken?(board, index)
      count += 1
    end
    index += 1
  end
  count
end

# Returns the identity of the current player, X or O, based on the number of turns that are completed.
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

# Helps the won?() method. Checks to see if, given an array of positions from the WIN_COMBINATIONS constant, if all those positions are filled on the board
def all_filled?(board, positions)
  positions.all? do | position |
    board[position] == "X" || board[position] == "O"
  end
end

# Returns true if all positions in the positions on the given board are "X" in the positions designated by the given positions array.
def all_X?(board, positions)
  positions.all? do | position |
    board[position] == "X"
  end
end

# Returns true if all positions on the board array that are on the given positions array are filled with "O"
def all_O?(board, positions)
  positions.all? do | position |
    board[position] == "O"
  end
end

# Returns the winning combination array if one is detected
def won?(board)
  WIN_COMBINATIONS.each do | combo |
    if (all_filled?(board, combo) && (all_X?(board, combo) || all_O?(board, combo)))
      return combo
    end
  end
  return false
end

# Returns true if board is full, false if not
def full?(board)
  board.all? do | space |
    space == "X" || space == "O"
  end
end

# Board must be full and not won.
def draw?(board)
  !won?(board) && full?(board)
end

# A game is over if it's won or drawn
def over?(board)
  won?(board) || draw?(board)
end

# Takes a winning board and returns "X" or "O" depending on which player won.
def winner (board)
  if won?(board)
    winning_combo = won?(board)
    board[winning_combo[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    if winner(board) == "X"
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
  else
    puts "Cats Game!"
  end
end
