WIN_COMBINATIONS=[
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
puts  "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts  "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i-1
end

def move(board,index,value)
  board[index] = value
end

def position_taken?(board,index)
board[index] == "X"|| board[index] == "O"
end

def valid_move?(board,index)
  index.between?(0,8) && !position_taken?(board,index)
end

def turn(board)
  user_input = gets.chomp
index = input_to_index(user_input)
if(valid_move?(board,index))
  move(board,index,"X")
  display_board(board)
else
  puts "Please enter another position:"
  turn(board)
end
end

def turn_count(board)
  count=0
  x=0
  while count<board.length
    if(board[count] == "X" || board[count] == "O")
      x+=1
    end
    count+=1
  end
  return x
end

def current_player(board)
if(turn_count(board) % 2 == 0)
  return "X"
else
  return "O"
end
end

def won?(board)
  board.all?{|p| p!=""||p!=" "}
count=0
while count < WIN_COMBINATIONS.length
  winner1 = WIN_COMBINATIONS[count].all?{ |el| board[el] == "X" }
  winner2 = WIN_COMBINATIONS[count].all?{ |el| board[el] == "O" }
if(winner1 || winner2 )
  return WIN_COMBINATIONS[count]
else
  false
end
count+=1
end
end

def full?(board)
  board.all?{ |el| el == "X" || el == "O"}
end

def draw?(board)
if(!won?(board) && full?(board))
  return true
else
  return false
end
if(!won?(board) && !full?(board) || won?(board))
  false
   end
end

def over?(board)
won?(board) || draw?(board) || full?(board)
end

def winner(board)
count =0
x=0
y=0
while count<board.length
  if(board[count] == "X" )
    x+=1
  elsif(board[count] == "O")
    y+=1
  end
  count+=1
end
if(x > y)
  return "X"
elsif( y > x)
  return "O"
else
  nil
end
end
def play(board)
while !over?(board)
    turn(board)
end # end of while
if(won?(board) && winner(board) == "X")
puts "Congratulations X!"

elsif(won?(board) && winner(board) == "O")
puts "Congratulations O!"

end
end #end of play
