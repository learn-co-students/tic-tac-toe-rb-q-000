# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
[0,1,2], 
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[2,4,6]

]

# Defines and displays the tic tac toe board
board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
display_board(board)

# Creates the Move method that takes a array, position and value.
def move(array,position,value = "X")
  array[position.to_i - 1] = value
end

# Checks to see if the position is taken and returns false if it is taken
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Checks to see if this was a valid move and returns 
def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board,position.to_i-1)

end

# takes in the user input and validates the user input 
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board,input)
    move(board,input,current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  board.select {|i| i == "X" || i == "O"}.count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |winner|
    winner.all? {|token| board[token] == "X"} || winner.all?{|token| board[token] == "O"}
   end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"} 
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if the_index_win = won?(board)
    board[the_index_win.first]  
  end
end
# Create the PLAY Method to bring it all together
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end






