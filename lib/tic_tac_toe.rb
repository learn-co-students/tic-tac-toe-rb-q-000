WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

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

def move(board, user_input, character)
  #user_input.to_i - 1
  board[user_input] = character
end

def position_taken?(board, index)
  index.to_i - 1

  if (board[index] == " " || board[index] == "" || board[index] == nil)
    return false

  else (board[index] == "X" || board[index] == "O")
    return true

  end
end

def valid_move?(board, index)
  #index.to_i - 1

  if (position_taken?(board, index) == false && index.between?(0, 8) == true)
    return true

  else position_taken?(board, index) == true
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)

  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
    counter += 1
  end
end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if (board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X") || (board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O")
      return win_combination # return the win_combination indexes that won.
    end
  end
  return false
end

def full?(board)
  board.all? do |index|
    index != " "
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board) || (turn_count(board) > 9)
end

def winner(board)
  if won?(board) && board.count("X") > board.count("O")
    return "X"
  elsif won?(board) && board.count("O") > board.count("X")
    return "O"
  else
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  else
  end
end
