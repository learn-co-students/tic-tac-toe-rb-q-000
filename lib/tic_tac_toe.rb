# Define WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #first column
  [1,4,7], #second column
  [2,5,8], #last column
  [0,4,8], #left to right diagonal
  [2,4,6]  #right to left diagonal
  ]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your move method here!
def move(board, position, char = 'X')
  board[position.to_i - 1] = char
end

# code your #position_taken? method here!
def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position]==nil
    false
  else
    true
  end
end

def valid_move?(board, position)
  index = position.to_i - 1
  if index.between?(0,8) && !position_taken?(board,index)
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.chomp
  until valid_move?(board,position) do
    puts "Please enter 1-9:"
    position = gets.chomp
  end
move(board, position, current_player(board))
display_board(board)
end

def turn_count(board)
  num_empty = board.count(" ") #count empty spaces
  9-num_empty # return number of occupied positions
end

def current_player(board)
  turn = turn_count(board)
  if turn.even?
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = board[win_combination[0]]
    position_2 = board[win_combination[1]]
    position_3 = board[win_combination[2]]

    if position_1 == "X" && position_2 =="X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 =="O" && position_3 == "O"
      return win_combination
    end
  end
  false
end

def full?(board)
  !board.any?{|position| position == " "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  win_index = won?(board)
  if win_index
    board[win_index[0]]
  end
end

def play(board)
  while !over?(board) do
    turn(board)
  end

  if !draw?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end



