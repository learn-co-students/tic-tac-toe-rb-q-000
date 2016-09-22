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

def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
board = [ " ", " ", " ", " ", " ", " ", " ", " ", " "]

def input_to_index(input)
  input.to_i - 1
end

def move(board, input, value)
  board[input.to_i - 9] = value
end


def position_taken?(board, input)
  if board[input.to_i - 9] == " "
    false;

  else true;
  end
end


def valid_move?(board, input)

  !position_taken?(board, input) && input.to_i.between?(1, 9)
end




def turn(board)
  puts "Please enter 1-9:"

  input = gets

  if valid_move?(board, input)
    move(board, input, value="X")
  else
    turn(board)
  end
end
