WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [6,4,2],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def play(board)
  while !over?(board)
    turn(board)
  end  

  if won?(board) 
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end  
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, character = "X")
  board[position.to_i-1] = character
end

def valid_move?(board,input)
# if 
    !position_taken?(board, input.to_i-1) && input.to_i.between?(1,9)
#    true
#  end
end

def position_taken?(board,position)
  if 
    board[position] == " " || board[position] == "" || board[position] == nil
    false 
  else 
    true
  end
end 

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
 if
    !valid_move?(board, input)
    turn(board) 
  end
  move(board,input, current_player(board)) 
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |slot|
    if slot == "X" || slot == "O"
    counter += 1
    end
  end  
  return(counter)
end

def current_player(board)
    if 
     turn_count(board).even? 
     "X"
    else 
     "O"
    end 
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_index|
    board[win_index[0]] == board[win_index[1]] && 
    board[win_index[0]] == board[win_index[2]] &&
    position_taken?(board, win_index[0])
  end
end

def full?(board)
  board.none? do |cell|
    cell == " " || cell == ""
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if win_board = won?(board)
     board[win_board[0]]
  end
end


