WIN_COMBINATIONS = [
[0, 1, 2],
[3, 4, 5],
[6, 7, 8],
[0, 3, 6],
[1, 4, 7],
[2, 5, 8],
[0, 4, 8],
[2, 4, 6],
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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    if index.between?(0, 8)
      true
    end
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count (board)
  counter = 0
  board.each do |i|
    if i == "X" || i == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0 || turn_count(board).even? == true # it's all even
    return  "X"
  else
    return  "O"
  end
end

def won?(board)
  if board.include? ("" || " ")
    return false
  else
    WIN_COMBINATIONS.find do |win_combination|
      win_combination.all? { |i| (board[i] == "X") } || win_combination.all? { |i| (board[i] == "O") }
    end
  end
end

def full?(board)
  if board.all? { |i| (i == "X" || i == "O") }
    return true
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else won?(board)
  return false
  end
end

def over?(board)
  if won?(board)
    return true
  else draw?(board)
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

#This is the end of the helper methods. Below starts the play method.

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
  puts "Cats Game!"
  end
end
