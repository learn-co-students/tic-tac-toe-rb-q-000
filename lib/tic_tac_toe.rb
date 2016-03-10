board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

WIN_COMBINATIONS = [
  [0,1,2], # Top Row
  [3,4,5], # Middle Row
  [6,7,8], # Bottom Row 
  [0,3,6], # First Column
  [1,4,7], # Second Column
  [2,5,8], # Third Column 
  [0,4,8], # First Diagonal 
  [2,4,6]  # Second Diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, input, value = "X")
  board[(input.to_i-1)] = value 
end

def position_taken?(board, location)
 !(board[location].nil?) && !(board[location] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  count = 0 
  board.each do |value| if (value == "X" || value == "O") 
    count = count + 1
  end
end 
  count 
end

def current_player(board)
  if turn_count(board) % 2 == 0 
     "X"
  else "O"
  end
end 

def won?(board) 
WIN_COMBINATIONS.each do |combination| 
  pos1 = board[combination[0]]
  pos2 = board[combination[1]]
  pos3 = board[combination[2]]

 if (((pos1 == pos2) && (pos2 == pos3)) && (position_taken?(board, combination[0])))
  return combination
else
  false
end 
end
return false  
end

def full?(board)
  outcome = false 
  board.each do |value| 
    if (value == "O" || value == "X")
      outcome = true 
    else return false
    end
  end
  return outcome 
end

def draw?(board)
  if (won?(board) == false && full?(board) == true) 
    true
  else 
    false
  end
end 


#takes in a board and returns 
def over?(board) 
  if (won?(board) == true || full?(board) == true)
    true
  else 
    false
  end
end 

def winner(board)
  if won?(board) == false 
    nil 
  else 
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board) 
    turn(board)
  end
if won?(board)
  winner = winner(board)
  puts "Congratulations! #{winner}!"
elsif draw?(board)
  puts "Cats Game!"
end 
end

