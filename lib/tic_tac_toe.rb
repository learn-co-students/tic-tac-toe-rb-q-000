# Define display_board that accepts a board and prints
# out the current state.
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
 puts "-----------"
 puts " #{board[3]} | #{board[4]} | #{board[5]} "
 puts "-----------"
 puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your move method here!
def move(board, position, player = "X")
  board[position.to_i - 1] = player
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# code your #valid_move? method here
def valid_move?(board, position)
  if position.to_i.between?(1, 9) && position_taken?(board, position.to_i - 1) == false
    true
  else
    false
  end
end

def turn(board)
  puts 'Please enter 1-9:'
  position = gets.strip
  if valid_move?(board, position) == true
    move(board, position, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |count|
    if count == "X" || count == 'O'
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2] ]
# Define won?, full?, draw?, over?, and winner below
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
 end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

def play(board)
  while over?(board) == false && draw?(board) == false
    turn(board)
  end
  if won?(board) != false && draw?(board) == false
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cats Game!"
  end
end

