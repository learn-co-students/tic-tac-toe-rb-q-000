def input_to_index(input)
  input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board, index)
  counter = 0
  if position_taken?(board, index) == true
    return counter += 1
  end
  return counter
end

def turn(board, index)
  puts "Please enter 1-9:"
  input = gets
  player = current_player(board, index)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board, index)
  end
end

def current_player(board, index)
  if turn_count(board, index) % 2 == 0
    return "O"
  else
    return "X"
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
def play(board, index)
  puts "Something in the play function"
  turn(board, index)
  while over?(board) == false
    turn(board, index)
  end
  if won?(board) == true
    puts "Congratulations player #{winner(board)}"
  elsif draw?(board) == true
    puts "The game is a draw."
  end
end
