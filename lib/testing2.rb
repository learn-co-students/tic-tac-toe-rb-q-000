WIN_COMBINATIONS=[[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char="X")
  board[position-1] = char
end

def position_taken?(board, position)
  if board[position] != " "
    return true
  else
    return false 
  end 
end

def valid_move?(board, position)
  if position.to_i.between?(1, 9)==true && board[position.to_i - 1]== " "
    return true
  else 
    return false
  end
end



def turn(board)
  x=0
  while x==0
  puts "Please enter 1-9:"
input=gets.to_i
if valid_move?(board, input)==true
  move(board, input, char="X")
x+=1
else 
  puts "try again"
end
end
display_board(board)
end

turn([" ", " ", " ", " ", " ", " ", " ", " ", " "])