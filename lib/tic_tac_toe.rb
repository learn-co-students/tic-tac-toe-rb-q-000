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
  print " #{board[0]} "
  print "|"
  print " #{board[1]} "
  print "|"
  puts " #{board[2]} "
  puts "-----------"
  print " #{board[3]} "
  print "|"
  print " #{board[4]} "
  print "|"
  puts " #{board[5]} "
  puts "-----------"
  print " #{board[6]} "
  print "|"
  print " #{board[7]} "
  print "|"
  puts " #{board[8]} "
  puts " "
end

def move(board, position, value = "X")
  position = position.to_i
  position = position - 1
  board[position] = value
end

def position_taken?(board, position)
  if board[position] == " "
    false
    elsif board[position] == "" || board[position] == nil
    false
  else
    true
  end
end

def valid_move?(board, position)
  position = position.to_i
  position = position - 1
  if position_taken?(board, position) == false && position.between?(0, 8)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position, current_player(board))
      display_board(board)
  else
    puts "Invalid input, please input valid input"
    turn(board)
end
end

def turn_count(board)
  turn = 0
  board.each do |place|
  if place == "X" || place == "O"
    turn += 1
  end
  end
  turn
end

def current_player(board)
  if turn_count(board) % 2 == 0
   "X"
  else
   "O"
  end
end

def won?(board)
 WIN_COMBINATIONS.detect do |position|
    if board[position[0]] == "X" && board[position[1]] == "X" && board[position[2]] == "X"
      position
     elsif board[position[0]] == "O" && board[position[1]] == "O" && board[position[2]] == "O"
      position
     else
     false
   end
  end
end

def full?(board)
  board.all? do |cell|
    cell == "X" || cell == "O"
  end
end

def draw?(board)
  if !won?(board) && full?(board)
     true
  elsif
     !won?(board) && !full?(board)
     false
   else
    won?(board)
     false
   end
  end

def over?(board)
won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if solution = won?(board)
  board[solution.first]
 else
  nil
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
end
end

