WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle
  [6,7,8], #bottom
  [0,3,6], #left down
  [1,4,7], #middle down
  [2,5,8], #right down
  [0,4,8], # diagonal down
  [6,4,2] # diagonal up
  ]

board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, token = "X")
  board[position.to_i-1] = token
end

def position_taken?(board, position)
  if (board[position] ==  " " || board[position] == "" || board[position] == nil)
     taken = false
  else
     taken = true
 end
end


def valid_move?(board, position)
  if position.to_i.between?(1,9)
    if !position_taken?(board, position.to_i-1)
      true
   end
end

position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |token|
    if token == "X" || token == "O"
    count += 1
  end
end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combination|
    board[combination[0]] == board[combination[1]] &&
    board[combination[1]] == board[combination[2]] &&
    position_taken?(board, combination[0])
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

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

