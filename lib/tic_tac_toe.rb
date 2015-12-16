# Define WIN_COMBINATIONS constant and set it equal to a nested array 
# filled with the index values for the various win combinations in tic tac toe.
WIN_COMBINATIONS = [ [0,1,2], #top row
                     [3,4,5], #middle row
                     [6,7,8], #bottom row
                     [0,3,6], #left column
                     [1,4,7], #center column
                     [2,5,8], #right column
                     [0,4,8], #left diagonal
                     [2,4,6]  #right diagonal
                   ]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board) 
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------" 
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Define the move method
def move(board, position, current_player= "X")
  board[position.to_i - 1] = current_player
end

# Define your #position_taken? method 
def position_taken?(board, position)
  board[position] != " " && board[position] != "" 
end

# Define the valid_move? method
def valid_move?(board, position)
 # position = position.to_i 
  position.to_i. between?(1, 9) && !position_taken?(board, position.to_i-1)
end

# Define turn method here
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if !valid_move?(board, input) 
    turn(board)
  end
  move(board, input, current_player(board))
  display_board(board)
end

# Define turn count method
def turn_count(board)
  count= 0
  board.each do |token|
    if token == "X" || token == "O"
      count +=1
    end
  end
return count
end

# Define current_player method
def current_player(board)
    turn_count(board).even?  ? current_player = "X" : current_player = "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]
      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]
      if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
         (position_1 == "O" && position_2 == "O" && position_3 == "O") then
         puts "Congratulations #{board[win_index_1]}!"
         puts win_combination 
         return win_combination
      end
   end
   false
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end
#def draw?(board)
  #true if full and not won
 # full?(board) && !won?(board) 
  #puts "Cats Game!"
#end

#def over?(board)
# draw?(board) || won?(board)
#end

def over?(board)
  if (full?(board) == true || draw?(board) == true || won?(board) != false) then
    true
  end
end

def winner(board)
  if won?(board) != false then
   WIN_COMBINATIONS.each do |win_combination|
     win_index_1 = win_combination[0]
     win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
     position_1 = board[win_index_1]
     position_2 = board[win_index_2]
     position_3 = board[win_index_3]
      if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
         (position_1 == "O" && position_2 == "O" && position_3 == "O") then
         return position_1
     
     end
    end
  end

end

# Define play method
def play(board)
 while !over?(board)
    turn(board)
    current_player(board)
  end
  won?(board)
  if draw?(board) then puts "Cats Game!"
  end
end
