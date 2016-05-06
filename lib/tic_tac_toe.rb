# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS=[
                  [0,1,2],
                  [3,4,5],
                  [6,7,8],
                  [0,3,6],
                  [1,4,7],
                  [2,5,8],
                  [0,4,8],
                  [6,4,2]
]

#build a board and a method that displays the board
board = [" "," "," "," "," "," "," "," "," "]
# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Adding Player Move to the Game Board
def move (board, location, player ="X")
  board[(location.to_i) -1 ]=player
end

# check if a position omn the board has been taken
def position_taken?(board, position)
  if board[position] == "" || board[position] == " " || board[position] == nil
      return false
   elsif board[position] == "X" || board[position] == "O"
      return true
  end
end

def position_taken?(board, position)
  if board[position] == "" || board[position] == " " || board[position] == nil
      return false
   elsif board[position] == "X" || board[position] == "O"
      return true
  end
end

#check if player made a valid move
def valid_move?(board, position)
  index = position.to_i-1

  if index.between?(0,8) && !position_taken?(board, index)
    return true
   else
    return false
   end
  end

#counts occupied position
def turn(board)
  puts "Please enter 1-9:"
  user_input = gets

  if valid_move?(board, user_input)
    move(board, user_input, token="X")
    display_board(board)
    return true
  else
    turn(board)
  end
end
