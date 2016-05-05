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
# 0 | 1 | 2   
#-----------
#3 | 4 | 5   
#-----------
# 6 | 7 | 8  

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} " 
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "  
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, token)
  #update board at position with token "X" or "O"
  index = position.to_i-1
  board[index] = token
end

def position_taken?(board, index)
  if board[index] == " "
    false
  else
    true
  end
end

def valid_move?(board, position)
  index = position.to_i-1
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter a move 1-9"
  position = gets.strip 
  if valid_move?(board, position)
    token = current_player(board)
    move(board, position, token)
    display_board(board)
    else 
    turn(board) 
    end
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

  # Define won?, full?, draw?, over?, and winner below
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
  won?(board) || full?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

  def play(board)
  input = gets
  turn_count = 0
  while turn_count < 9 && !over?(board)
    turn(board)
    turn_count+=1
    if 
  end
end




  #counter = 0
  #loop turn until over
  #if full?(board) || draw?(board) 
   # puts "Its a draw!"
    ## puts "Congratulations {input}!"
    #else

    #end
    #if 
  ## turn(board)
  #end
#end


