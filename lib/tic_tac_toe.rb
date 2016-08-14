# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8],
  [0,3,6], [1,4,7], [2,5,8],
  [0,4,8], [2,4,6]
]

# Define display_board that accepts a board and prints
# out the current state.

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Defines the method that converts a string user_input to an integer
def input_to_index(input)
  input = input.to_i - 1
end

# Defines the method that sets an "X" or an "O" at a board position.
def move(board, index, character)
  board[index] = character
end

# Defines the method that determines if a board position is currently occupied.
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Defines the method to evaluate if the desired position has been taken and is a valid position.
def valid_move?(board, index)
  if !(position_taken?(board, index)) && index.between?(0, 8)
    true
  else
    false
  end
end

#Defines the method to encapsulate the logic for a single turn of Tic-Tac-Toe.
def turn(board)
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.find do |win_combination|
    board_portion = [board[win_combination[0]], board[win_combination[1]], board[win_combination[2]]]
    board_portion.join == "XXX" || board_portion.join == "OOO"
  end
end

def full?(board)
  index = [0,1,2,3,4,5,6,7,8]
  index.all? {|i| position_taken?(board, i)}
end

def draw?(board)
  if !(won?(board)) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  board_return = won?(board)
  #puts board_return.inspect
  if board_return.class == Array
    if board[board_return[0]] == "X"
      return "X"
    else
      return "O"
    end
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
