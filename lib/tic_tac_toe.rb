

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
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn(board)
  puts "Please enter 1-9:"
  location = gets.strip

  if valid_move?(board, location)
    move(board, location, current_player(board))
  else
    turn(board)
  end
end

def move(board, location, token)
  location = location.to_i-1
  board[location] = token
  display_board(board)
end

def valid_move?(board, location)
  location = location.to_i-1
  location.between?(0,8) && !position_taken?(board, location)
end

def turn_count(board)
  counter = 0

  board.each do |x|
    if(x != " ")
      counter += 1
    end
  end
  return counter
end

# def turn_count(board)
#   counter = 0
#   board.each {|i| x != " " counter += 1}
#   return counter
# end

def play(board)
  until over?(board)
    turn(board)
  end

  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else draw?(board)
    puts "Cats Game!"
  end
end
# until the game is over
#   take turns
# end

# if the game was won
#   congratulate the winner
# else if the game was a draw
#   tell the players it has been a draw
# end

def current_player(board)
  count = turn_count(board)

  if count % 2 == 0
    return "X"
  else
    return "O"
  end
end

def player_number
  if current_player(board) == "X"
    return "Player 1"
  else
    return "Player 2"
  end
end

# Helper Method - position taken if true, not taken if false.
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

#return false/nil if there is no win combination present 
#in the board and return the winning combination indexes as an array if there is a win.
 def won?(board)
  WIN_COMBINATIONS.detect do |combo|
     board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && position_taken?(board, combo[0])
  end
 end

#return true if every element in the board contains either an "X" or an "O"
def full?(board)
  board.all? {|x| x != " "}
end

#returns true if the board has not been won and is full 
#and false if the board is not won and the board is not full, and false if the board is won
def draw?(board)
  if won?(board) 
    false 
  else full?(board) 
  end
end

#returns true if the board has been won, is a draw, or is full. 
def over?(board)
  won?(board) || draw?(board)
end

#return the token, "X" or "O" that has won the game given a winning board
# def winner(board)
#   if board[won?(board)[0]] 
#     return board[won?(board)[0]] 
#   else !won?(board)
#     return nil
#   end
# end


def winner(board)
  if winner = won?(board)
    board[won?(board)[0]]
  end
end