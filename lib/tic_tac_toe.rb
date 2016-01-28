# Helper methods

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # First column
  [1,4,7], # Second column
  [2,5,8], # Third column
  [0,4,8], # Diagonal left-top to right-botton
  [2,4,6]  # Diagonal left-bottom to right-top
]

# Display board
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Move
def move(board, input, character = current_player(board))
  location = input.to_i - 1
  board[location] = character
end

# Position taken?
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Valid move?
def valid_move?(board, location)
  location = location.to_i - 1
  if location.between?(0, 8) == true && position_taken?(board, location) == false
    true
  else
    false
  end
end

# Turn
def turn(board)
  puts "Please enter 1-9:"
  location = gets.chomp
  if valid_move?(board, location)
    move(board, location, character = current_player(board))
  else
    turn(board)
  end
end

# Turn count
def turn_count(board)
  counter = 0
  board.each do |element|
    if element == "X" || element == "O"
      counter += 1
    end
  end
  counter
end

# Current player
def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

# Won?
def won?(board)
  WIN_COMBINATIONS.find do | win_combination |

    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      false
    end
  end
end

# Full?
def full?(board)
board.all? { | index | index == "X" || index == "O"}
end

# Draw?
def draw?(board)
  if !(won?(board)) && full?(board)
    true
  else
    false
  end
end

# Over?
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

# Winner
def winner(board)
  if won?(board)
  return board[won?(board)[0]]
  else
    nil
  end
end

# Play
def play(board)
  display_board(board)
  if !over?(board)
    turn(board)
    play(board)
  else 
    if !over?(board)
      play(board)
    elsif over?(board)
      if draw?(board) || full?(board)
        # display_board(board)
        puts "Cats Game!"
      elsif won?(board)
        # display_board(board)
        puts "Congratulations #{winner(board)}!"
      else
        puts "Adam's error"
      end
    end
  end
end
