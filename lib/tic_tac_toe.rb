WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6], # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right column
  [0,4,8],  # First diagonal
  [2,4,6],  # Second diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, player="X")
  position=position.to_i
  board[position-1]=player
end

def position_taken?(board,position)
  if (board[position]==" " || board[position]=="" || board[position]==nil)
    return false
  else
    return true
  end
end

def valid_move?(board,position)
  position=position.to_i
  if (position.between?(1, 9)==true && position_taken?(board,position-1)==false)
    return true
  else 
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip 
  until valid_move?(board,input)==true
    puts "Please enter 1-9:"
    input = gets.strip 
  end
move(board,input,current_player(board))
display_board(board)
end

def turn_count(board)
  counter=0
  board.each do |b|
    if (b=="X" || b=="O") 
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board)%2==0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return [win_index_1, win_index_2, win_index_3]
    end 
  end
end

def full?(board)
  sol = true
  board.detect do |i|
    if position_taken?(i,0)==false
      sol = false
    end
  end
  return sol
end

def draw?(board)
  if (won?(board)==nil && full?(board)==true)
    return true
  else
    return false
  end
end

def over?(board)
  if (won?(board)!=nil || draw?(board)==true || full?(board)==true)
    return true
  else 
    return false
  end
end

def winner(board)
  if won?(board)!=nil
    win = won?(board)
    return board[win[1]]
  end
end

def play(board)
  while over?(board) == false do
    turn(board)
  end
  if draw?(board)==true
    puts "Cats Game!"
  elsif won?(board)!=nil 
    puts "Congratulations #{winner(board)}!"
  end
end

