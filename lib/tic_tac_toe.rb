WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Top left to bottom right
  [2,4,6]  # Top right to bottom left
]

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, input, player="X")
  board[(input.to_i)-1] = player
  return board
end

def position_taken?(board, position)
 !(board[position] == "" || board[position] == nil || board[position] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !(position_taken?(board, position.to_i-1))
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board,input)
    move(board, input, current_player(board))
  else
  turn(board)
  end
  display_board(board)
end

def turn_count(board)
  turns_taken = 0
  board.each do |count|
  if count == "X" || count == "O"
    turns_taken +=1
  end
end
  turns_taken
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
    WIN_COMBINATIONS.find do |win_line|
    board[win_line[0]] == board[win_line[1]] &&
    board[win_line[1]] == board[win_line[2]] &&
    win_line.all? { |counter| board[counter] == "X" } || win_line.all? { |counter| board[counter] == "O" }
  end
end

def full?(board)
  board.all? { |counter| counter == "X" || counter == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if won?(board)
  board[won?(board)[0]]
  end
end