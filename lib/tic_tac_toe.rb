def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = "X")
  board[location.to_i - 1] = current_player
end

# Helper Method
def position_taken?(board, location)
  #returns false (pos empty) if either inner statement eval true
  #returns true (pos taken) if either inner statement eval false
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  #prompt user for input
  puts "Please enter 1-9:"
  #get user input
  input = gets.strip
  #check input validity
  #if invalid
  if !(valid_move?(board, input))
    #recursive call to turn
    turn(board)
  else
    #process the move
      #input is user's input
      #current_player(board) determines "X" or "O"
    move(board, input, current_player(board))
  end
  #display new board
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |marker|
    if marker == "X" || marker == "O"
      counter +=1
    end
  end
  return counter
end

#if counter is even or zero
  #current player is "X"
#else
  #current player is "O"

def current_player(board)
  #ternary operator
  #if initial statement (left of ?) evaluates to true
    #return value to left of :
  #else
    #return value to right of :
  return turn_count(board) % 2 == 0 ? "X" : "O"
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  #each array below is referred to as a win_combo
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #left col
  [1, 4, 7], #middle col
  [2, 5, 8], #right col
  [0, 4, 8], #left-right diag
  [6, 4, 2], #right-left diag
]

def won?(board)
  #detect first win_combo in WIN_COMBINATIONS that
  WIN_COMBINATIONS.detect do |win_combo|
    #contains all Xs on the board OR
    win_combo.all?{|marker| board[marker] == "X"} || 
    #contains all Os on the board
    win_combo.all?{|marker| board[marker] == "O"}
  end
  #detect returns 1st element that evaluates true
  #if none, returns nil
end

def full?(board)
  #full? returns true if all board locations are taken by Xs or Os
  board.all?{|location| location == "X" || location == "O"}
end

def draw?(board)
  #if won? is true or full? is false, return false
  if won?(board) || !full?(board)
    return false
  #if full? is true, return true
  elsif full?(board)
    return true
  end
end

def over?(board)
  #if won? is true or full? is true, return true
  if won?(board) || full?(board)
    return true
  #else return false
  else
    return false
  end
end

def winner(board)
  #if won? is true
  if won?(board)
    #won? returns win_combo array
    #set var to win_combo array's 1st index for clarity
    win_combo_first_item = won?(board)[0]
    #return value ("X" or "O") at that index in board
    board[win_combo_first_item]
  else
    return nil
  end
end

def play(board)
  #until the game is over
  until over?(board) || draw?(board)
    #alternate turns
    turn_count(board)
    current_player(board)
    turn(board)
    
  end

  #if won, #congratulate winner
  if won?(board) 
    puts "Congratulations #{winner(board)}!" 
  end
  
  #if draw, declare cats game
  if draw?(board)
    puts "Cats Game!"
  end


end











