WIN_COMBINATIONS = [
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right column
  [0,4,8],  # Left diagonal
  [6,4,2]   # Right diagnonal
 ]

def display_board(board)
  puts   " #{board[0]} | #{board[1]} | #{board[2]} "
  puts   "-----------"
  puts   " #{board[3]} | #{board[4]} | #{board[5]} "
  puts   "-----------"
  puts   " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(array, position, character = "X")
  position = position.to_i - 1
  array[position] = character
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  else board[position] == "X" || board[position] == "O"
    true
  end
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  valid = false
  until valid == true do
   puts "Please enter 1-9:"
   input = gets.strip
   valid = valid_move?(board, input)
  end
  board = move(board, input, current_player(board))
  display_board(board)
  board
end

def turn_count(board)
  9 - board.count(" ")
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def won?(board)
 WIN_COMBINATIONS.each do |combination|
  if position_taken?(board, combination[0]) && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]]
     return combination
   end
 end
 return false
end

def full?(board)
 [0,1,2,3,4,5,6,7,8].each do |position|
   if !position_taken?(board, position)
     return false
   end
 end
 true
end

def draw?(board)
  if !won?(board) && full?(board)
   return true
 end
 false
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
 return true
 end
 return false
end

def winner(board)
 winning_combination = won?(board)
 if winning_combination
   return board[winning_combination[0]]
 end
 nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end
