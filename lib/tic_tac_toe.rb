WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

# Helper Methods
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

def turn_count(board)
  counter = 0
  board.each do [position]
    if position == "X" || position == "O"
      counter += 1
    end
  end
  return counter
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def current_player(board)
  if turn_count(board).odd
    return "X"
  else
    return "O"
  end
end

def won?(board)
  pass =
    WIN_COMBINATIONS.each do |win_combination|
      index_1 = win_combination[0]
      index_2 = win_combination[1]
      index_3 = win_combination[2]
      if (board[index_1] == "X" && board[index_2] == "X" && board[index_3] == "X") || (board[index_1] == "O" && board[index_2] == "O" && board[index_3] == "O")
        return win_combination
      end
    end
    return false
end

def full?(board)
  counter = 0
  board.each do |value|
    if value == "X" || value == "O"
      counter += 1
    end
  end
  if counter == 9
    return true
  else
    return false
  end
end

def draw?(board)
  if !won?(board)
    return true
  elsif (won?(board) == false && full?(board) == false) || won?(board) ==  true
    return false
  end
end

def over?(board)
  if full?(board) == false
    return false
  elsif won?(board) == true || full?(board) == true || draw?(board) == true
    return true
  end
end

def winner(board)
  if !won?(board)
    return nil
  else
    winning_array = won?(board)
    winning_index = winning_array[0]
    if board[winning_index] == "X"
      return "X"
    else
      return "O"
    end
  end
end

# Define your play method below
def play(board)
  turn(board)
  while over?(board) == false
    turn(board)
  end
  if won?(board) == true
    puts "Congratulations player #{winner(board)}"
  elsif draw?(board) == true
    puts "The game is a draw."
  end
end
