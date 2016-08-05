WIN_COMBINATIONS = [ 
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
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

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  board[index] != " "
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end 

def turn(board)
  puts "please enter 1-9" 
  input = gets
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
board.each do |item|
  if item != " "
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
  WIN_COMBINATIONS.find do |item|
    first = item[0]
    second = item[1]
    third = item[2]
    board[first] == board[second] && board[second] == board[third] && board[first] != " "
  end
end

def full?(board)
  board.all? do |item|
    item != " " 
  end
end

def draw?(board)
 !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  combination = won?(board)
  if combination
    index = combination[0]
    board[index] 
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


