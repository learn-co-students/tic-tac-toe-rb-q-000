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

def input_to_index(index)
  index.to_i - 1
end

def move(board, index, value)
  board[index.to_i - 9] = value
end


def position_taken?(board, index)
  if board[index.to_i] == " "
    false;

  else true;
  end
end


def valid_move?(board, index)

  !position_taken?(board, index) && index.to_i.between?(0, 8)

end


def turn(board)

  puts "Please enter 1-9:"
  input = gets
  if !valid_move?(board, index)
    turn(board)
  else
    valid_move?(board, index)
    move(board, index, value="X")
  end
end
