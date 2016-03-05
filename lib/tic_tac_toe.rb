# Helper Method
# returns true/false based on position in board

# Defines the WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left Vertical
  [1,4,7],  # Middle Vertical
  [2,5,8],  # Right Vertical
  [0,4,8],  # Diagonal L-R row
  [2,4,6]  # Diagonal R-L row
]

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

# display_board Method
# prints arbitrary arrangements of the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# valid_move Method
# returns true/false based on position
def valid_move?(board, input)
  input.to_i.between?(1,9) && !position_taken?(board, input.to_i-1)
end

# won? Method
# determines game win
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

# full Method
# determines board is full
def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

# draw Method
# determines a draw
def draw?(board)
  !won?(board) && full?(board)
end

# over? Method
# determines if the game is over
def over?(board)
  won?(board) || draw?(board)
end

# turn Method
# makes valid moves
# asks for input again after a failed validation
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if !valid_move?(board, input)
    turn(board)
  end
  move(board, input, current_player(board))
  display_board(board)
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# current_player Method
# returns the correct player
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

# turn_count Method
# counts occupied positions
def turn_count(board)
  turns = 0
  board.each do |token|
    if token =="X" || token == "O"
      turns +=1
    end
  end
  turns
end

# move Method
# allows "X" player and "O" player
def move(board, input, current_player = "X")
  board[input.to_i-1] = current_player
end

# winner Method
# determines winner
def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end
