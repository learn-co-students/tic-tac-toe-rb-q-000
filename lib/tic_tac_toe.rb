WIN_COMBINATIONS = [
   [0,1,2],
   [3,4,5],
   [6,7,8],
   [0,3,6],
   [1,4,7],
   [2,5,8],
   [0,4,8],
   [6,4,2]
 ]

board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
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

def move(board, position, value = "X")
  board[position.to_i-1] = value
end

def valid_move?(board,position)
  position = position.to_i
   if ((position.to_i).between?(1,9) == true && (position_taken?(board,(position.to_i-1)) == false)) 
    true
  else
    false
  end
end

def position_taken?(board,position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  else
    true
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
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

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board,input)
    move(board,input, current_player(board))
  elsif
    turn(board)
  end
end
  display_board(board)

def turn_count(board)
  num_of_turns = 0
  board.each do |token|
    if token == "X" || token == "O"
      num_of_turns += 1
    end
  end
num_of_turns

end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end
 
def winner(board)
  if winning_combo = won?(board)
     board[winning_combo.first]
  end
end
