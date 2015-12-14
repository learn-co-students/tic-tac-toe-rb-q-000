WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left side
  [2,5,8], #right side
  [0,4,8], #first diagonal
  [2,4,6], #second diagonal
  [1,4,7]  #down the middle
 ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, input, char = "X")
  input = input.to_i
  board[input - 1] = char
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  elsif board[position] == "X" || board[position] == "O"
    true
  end
end

def valid_move?(board, position)
  position = position.to_i
  if position_taken?(board, position-1) == false && position.between?(1, 9) == true
     true
  else
    false
  end
end

def turn(board)
  puts "It is #{current_player(board)}'s turn. Please enter 1-9:"
  position = gets.chomp
  if valid_move?(board, position) == true
    move(board, position, current_player(board))
    puts "Thank you!  Here is the current board."
    display_board(board)
  else
    puts "Error! Your previous response was not allowed.  Please try again."
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.select do |count|
    if count == "X" || count == "O"
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
  WIN_COMBINATIONS.detect do |win_combination| #detect will return only the values in the array that allow the condition stated to return true
    position_1 = board[win_combination[0]] #sets position_1 to the first position in the current winning array being iterated
    position_2 = board[win_combination[1]] #sets position_2 to the second position in the current winning array being iterated
    position_3 = board[win_combination[2]] #sets position_3 to the third position in the current winning array being iterated

    (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O") #stated condition we are testing
  end
end

def full?(board)
  board.none? do |i| #checking to make sure none of the spots on the board are empty
    i == " "
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    position = board[won?(board)[0]]
    return position
  else
    nil
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
 if won?(board) && winner(board) == "X"
    puts "Congratulations X!"
 elsif won?(board) && winner(board) == "O"
    puts "Congratulations O!"
 elsif draw?(board)
   puts "Cats Game!"
 end
end
