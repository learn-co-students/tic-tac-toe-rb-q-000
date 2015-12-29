# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #= Top Row
  [3,4,5], #= Middle Row
  [6,7,8], #= Bottom Row
  [0,3,6], #= Left Vertical
  [1,4,7], #= Middle Verticle
  [2,5,8], #= Right Verticle
  [0,4,8], #= Diagnol top left to bottom right
  [6,4,2] #= Diagnal bottom left to top right
  ]

# display board
def display_board(board)
  puts" #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts" #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts" #{board[6]} | #{board[7]} | #{board[8]} "
end

# move

def move(board, option, char="X")
  option = option.to_i
  board[option - 1] = char
  return board
end

def play(board)
  input = gets
end