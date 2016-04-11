welcome = "Welcome to Tic Tac Toe!"

WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # mid row
  [6,7,8], # bot row
  [0,3,6], # left col
  [1,4,7], # mid col
  [2,5,8], # right col
  [0,4,8], # diag to right
  [6,4,2]  # diag to left
  ]
board = [ " ", " ", " ", " ", " "," ", " ", " ", " " ]

def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts " ----------- "
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts " ----------- "
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_marker = "X")
  board[location.to_i-1] = current_marker
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
if !position_taken?(board, position.to_i-1) && position.to_i.between?(1, 9)
  true
  else
  false
end
  end

def current_player(board)
  if turn_count(board) % 2 == 0
     "X"
    else
     "O"
end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    current_marker = current_player(board)
    move(board, position, current_marker)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
 board.each do |number|
    if number != " "
    counter += 1
   end
  end
   counter
end



def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all? do |space|
    space == "X" || space == "O"
  end
end

def draw?(board)
full?(board) && !won?(board)
end

def over?(board)
draw?(board) || won?(board)
end

def winner(board)
  if winning_combo = won?(board)
   board[winning_combo[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end