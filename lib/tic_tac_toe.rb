

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
  print " #{board[0]} | #{board[1]} | #{board[2]} "
  print "-----------"
  print " #{board[3]} | #{board[4]} | #{board[5]} "
  print "-----------"
  print " #{board[6]} | #{board[7]} | #{board[8]} "
end


def move(board, play, char = "X")
  int_play = play.to_i
  int_play -= 1

  board[int_play] = char
end

def valid_move?(board, position)
   position = position.to_i
   position -= 1

    if position.between?(0, 8) == !true
      return false
    else 
      position_taken?(board, position)
    end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  position = position.to_i

  if(valid_move?(board, position))
    move(board, position, "X")
    display_board(board)
  else
    turn(board)
  end
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

def current_player(board)
  count = turn_count(board)

  if count % 2 == 0
    return "X"
  else
    return "O"
  end
end

# Helper Method
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
  won?(board) || full?(board)
end

#return the token, "X" or "O" that has won the game given a winning board
def winner(board)
  if board[won?(board)[0]] 
    return board[won?(board)[0]] 
  else !won?(board)
    return nil
  end
end


def winner(board)
  if winner = won?(board)
    board[won?(board)[0]]
  end
end