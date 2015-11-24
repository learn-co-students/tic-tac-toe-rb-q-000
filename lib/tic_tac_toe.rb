

board = [" "," "," "," "," "," "," "," "," "]
def display_board(board)
  

  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def play(board)
  while !over?(board)
    turn(board)

  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end
end


def move(board, position, character="X")
  board[position.to_i-1]=character
end

def turn(board)
  puts "Please enter 1-9:"
  input=gets.strip
  if valid_move?(board,input)
    move(board,input,current_player(board))
    display_board(board)
  else
    turn(board)
  end 
end 

def valid_move?(board,position)
  position=position.to_i-1
  
  if position>8 || position<0
    return false
  elsif board[position]=="X" || board[position]=="O"
    return false
  else 
    return true
  

  end
end

def turn_count(board)
  board.count do |token| 
    token == "X" || token == "O"
  end
end

def current_player(board)
  if turn_count(board) % 2 == 0 
    return "X"
  else
    return "O"
  end
end 


def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end


WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Left down diagonal
  [6,4,2]  # Left up diagonal
]

def won?(board)
  WIN_COMBINATIONS.detect do |win_index|
    board[win_index[0]] == board[win_index[1]] &&
    board[win_index[1]] == board[win_index[2]] &&
    position_taken?(board, win_index[0])
  end
end

def full?(board)
  board.all? do |taken|
    taken=="X" || taken=="O"
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
   
 end
end

def over?(board)
  if draw?(board) || won?(board) 
    return true
  end
end

def winner(board)

  if won?(board) 
    board[won?(board)[0]]
  end
end