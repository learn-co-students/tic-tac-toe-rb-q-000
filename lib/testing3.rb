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

def turn_count(board)
  x=0
  board.each do |element|
    if element == "X" || element == "O"
      x+=1
    end 
  end 
  return x 
end 

def current_player(board)
  if turn_count(board) % 2 == 0 
    return "X"
  else
    return "O"
  end
end

def won?(board)
WIN_COMBINATIONS.each do |array|
  test_array=[]
  array.each do |element|
    if position_taken?(board, element)
    test_array << board[element]
  end
end
if test_array != [] && (test_array[0] == test_array[1] && test_array[0] == test_array[2])
  return array
end
end
return false 
end 

def full?(board)
  board.all? do |element|
    element == "X" || element == "O"
  end 
end 

def draw?(board)
  if won?(board) == false && full?(board) == true 
    return true 
  else 
    return false
  end 
end 

def over?(board)
  if draw?(board) 
    return true
  elsif full?(board)
    return true
  elsif won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) 
    puts won?(board)[1]
    return board[won?(board)[0]]
  end
end

puts winner(["X", " ", " ", " ", "X", " ", " ", " ", "X"])