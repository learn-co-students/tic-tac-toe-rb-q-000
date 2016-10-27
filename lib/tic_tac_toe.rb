WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  output = user_input.to_i - 1
end

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  elsif board[index] == "X" || board[index] == "O"
    true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index) == true
    move(board, index, character = current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |turn|
  if turn == "X" || turn == "O"
    counter += 1
  end
  end
  counter
end

def current_player(board)
   if turn_count(board) % 2 == 0
    "X"
   else
    "O"
   end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_combination
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
  end
end
return false
end

def full?(board)
board.all? do |pos|
  if pos == "X" || pos == "O"
    true
  else
    return false
end
end
end

def draw?(board)
  won?(board)
  if full?(board) == true && won?(board) == false
    true
  else
    false
  end
end

def over?(board)
  if won?(board) != false
    true
  elsif draw?(board) == true
    true
  else
    false
  end
end

def winner(board)
x = won?(board)
if x
  index = x[0]
  position = board[index]
  index1 = x[1]
  position1 = board[index1]
  index2 = x[2]
  position2 = board[index2]
  if position == "X" && position1 == "X" && position2 == "X"
    return "X"
  elsif position == "O" && position1 == "O" && position2 == "O"
    return "O"
  end
else
end
end

def play(board)
    until over?(board) == true
      turn(board)
    end
    if winner(board) == "X"
      puts "Congratulations X!"
    elsif winner(board) == "O"
      puts "Congratulations O!"
    else
      puts "Cats Game!"
    end
end
