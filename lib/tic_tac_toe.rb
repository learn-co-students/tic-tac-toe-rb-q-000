
WIN_COMBINATIONS = [
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Vertical row
  [1,4,7],  # Vertical Middle row
  [2,5,8],  # Vertical row
  [0,4,8],  # Diagonal Row
  [6,4,2]   # Diagonal Row
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} ",
       "-----------",
       " #{board[3]} | #{board[4]} | #{board[5]} ",
       "-----------",
       " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, input, char = "X")
  position = input.to_i - 1
  board[position] = "#{char}"
end  

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  else board[position] == "X" || "O"
    true  
  end  
end  

def valid_move?(board, position)
  position = position.to_i - 1
  if position.between?(0,8) && !position_taken?(board, position)
    true
   else
    false
   end 
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position) == true
    move(board, position, current_player(board)) 
  else 
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
    counter += 1
    end
  end  
  counter
end 

def current_player(board)
 turn_count(board).even? ? "X" : "O" 
end  

def won?(board)
  WIN_COMBINATIONS.detect do |combo| 
    combo.all? {|location| board[location] == "X" } || combo.all? {|location| board[location] == "O" }
  end
end  

def full?(board)
  if board.any? {|location| location == " "}  
    false
  else
    true
  end    
end

def draw?(board)
  full?(board) && !won?(board) ? true : false
end     

def over?(board)
 won?(board) || draw?(board) ? true : false
end  

def winner(board)
  if won?(board)
   board[won?(board)[0]] # return the value of index 0 of the array returned from the won? method
  else
    return nil
  end  
end

def play(board)
 until over?(board)
  turn(board) 
 end 
 if won?(board)
  puts "Congratulations #{winner(board)}!"
 else draw?(board)
  puts "Cats Game!" 
 end 
end 