# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom Row
  [0,3,6], # first column
  [1,4,7], #second column
  [2,5,8], #third column
  [0,4,8], # R to L diagonal
  [2,4,6] # L to R diagonal
]

# Display Board
def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Determine Current Player
def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn == "X" || turn =="O"
      counter +=1
    end
  end
return counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

# Determine if Position Taken
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Determine if Valid Move
def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

# Make The Player's Move
def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

#Play a Turn
def turn(board)
puts "Please enter a position: "
  position = gets.to_i
  
  until valid_move?(board, position) do
    position = gets.to_i
  end
    move(board, position, current_player(board))
  
  display_board(board)

end



# Check if We Have a Winner
def won?(board)
  WIN_COMBINATIONS.each do |win_array|

  win_index_1 = win_array[0]
  win_index_2 = win_array[1]
  win_index_3 = win_array[2]

  position_1 = board[win_index_1] # load the value of the board at win_index_1
  position_2 = board[win_index_2] # load the value of the board at win_index_2
  position_3 = board[win_index_3] # load the value of the board at win_index_3

      if ((position_taken?(board, win_index_1) && position_1 =="X") && (position_taken?(board, win_index_2) && position_2 =="X") && (position_taken?(board, win_index_3) && position_3 =="X") or 
        (position_taken?(board, win_index_1) && position_1 =="O") && (position_taken?(board, win_index_2) && position_2 =="O") && (position_taken?(board, win_index_3) && position_3 =="O"))
       return win_array
    end
  end
         return false
end

# Check if Board is Full
def full?(board)
  board.all? {|i| (i =="X" || i =="O")}
end

# Check if we have a Draw
def draw?(board)
  if !won?(board) && full?(board) 
    return true 
  elsif !won?(board) && !full?(board) 
    return false 
  elsif won?(board) 
    return false
  end
end

# Check if Game Over?
def over?(board)  
won?(board) || full?(board) || draw?(board) ? true : false 
end

# Declare the Winner
def winner(board)
  if over?(board) == true
    return board[won?(board)[0]]
  end
end

# Play the Game
def play(board)
  until over?(board) == true
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end

