#1 Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

#2 Shows the current state of board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#3 Makes a move on the board, used in next help method, 
def move(board, location, token ='X')
  location = location.to_i-1 
  board[location] = token
end

#4 Checks to see if the open for a move or not. 
def position_taken?(board, location)
  if board[location] ==" "
  	false 
  elsif board[location]==""
  	false
  elsif board[location]== nil
  	false	
  else
  	true
  end
end

#5 Determines as to whether the user's input is valid, that bhe input is between 1 & 9 (0 & 8) and the space is no longer taken
def valid_move?(board, location)
  location = location.to_i-1 
  if location.between?(0,8) && !position_taken?(board, location)
  	true 
  else
  	false
  end
end

#6 Take a turn in the game, uses helper methods #valid_move?, #move, #position_open?, and #turn
def turn(board)
  puts "Please enter 1-9:"
  location = gets.chomp
  if valid_move?(board, location) #valid_move? uses #position_open? as helper
    token = current_player(board)
    move(board, location, token)
  else 
  	turn(board)
  end
end

#7 Counts the amount of turns that have been played 
def turn_count(board)
  number_turns = 0 
  board.each do |space|
    if space == "X" || space == "O"
      number_turns += 1
    end	
  end
  return number_turns
end

#8 Determines if it is X's turn of O's turn 
def current_player(board)
  turn_count(board) % 2 == 0 ? "X": "O"
end

#9 Determines if there is a winner
def won?(board)
  WIN_COMBINATIONS.each do |win|
  	win_index_1 = win[0]
  	win_index_2 = win[1]
  	win_index_3 = win[2]

  	position_1 = board[win_index_1]
  	position_2 = board[win_index_2]
  	position_3 = board[win_index_3]
  
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win
    else
      false
    end
  end 
  return false
end

#10 determines if the board is full 
def full?(board)
   board.none?{|i| i ==" "}
end

#11 determines if the game is a draw
def draw?(board)
   if won?(board) == false  && full?(board) == true
     true 
   elsif won?(board) == false  && full?(board) == false
     false 
   end  
end	

#12 determines if the game is over
def over?(board)
	if won?(board) != false || full?(board) || draw?(board)
	  true 
	else 
	  false
	end
end

#13 determines how the game was one, and by whom. Remember won?(board) retunrs the winning row 
def winner(board)
   if won?(board)!=false
     victory = won?(board)
     if board[victory[0]] == "X"
       "X"
     else
       "O"
     end 
   end 
end

#14 Play the entire game 
def play(board)
  round = 0
  until over?(board) or round >9 or draw?(board) or won?(board)!=false
    turn(board)
    round += 1
    display_board(board) 
  end
  
  if won?(board)!= false 
    victory = winner(board)
    puts "Congratulations #{victory}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
  	
end



