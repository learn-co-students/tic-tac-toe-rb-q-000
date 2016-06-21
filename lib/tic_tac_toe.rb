WIN_COMBINATIONS = [
[0,1,2], # Top row
[3,4,5], # Middle row
[6,7,8], # Bottom row
[0,3,6], # First column
[1,4,7], # Second column
[2,5,8], # Third column
[0,4,8], # Top left bottom right diagonal
[2,4,6]  # Top right bottom left diagonal
]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end # Define display_board that accepts a board and prints
# out the current state.

def input_to_index(position)
  index = position.to_i
  index = index - 1
  return index
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if index < 0 || index > 8
    return false
  else
    if position_taken?(board, index)
      return false
    else
      return true
    end
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  counter = turn_count(board)
  remainder = counter % 2
  return remainder == 0 ? "X" : "O"
end

def turn(board)
  loop do
    puts "Please enter 1-9:"
    position = gets.strip
    index = input_to_index(position)
    if valid_move?(board, index)
      value = current_player(board)
      move(board, index, value)
      display_board(board)
      break
    end
  end
end

def all_same(winning_combo, token, board)
  winning_combo.all? do |position|
    board[position] == token
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |winning_combo|
    if all_same(winning_combo, "X", board) == true || all_same(winning_combo, "O", board) == true
      return winning_combo
    end
  end
  return false
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  !won?(board) and full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    winning_combo = won?(board)
    token = board[winning_combo[0]]
    return token
  else
    return nil
  end
end

def play(board)
  while !over?(board) do
    turn(board)
  end
  if over?(board)
    if draw?(board)
      puts "Cats Game!"
    else
      token = winner(board)
      puts "Congratulations #{token}!"
    end
  end
end
