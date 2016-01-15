# Helper Method
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

# Displays board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Places mark on board
def move(board, input, typ = "X")
  input = input.to_i - 1
  board[input] = typ
end

# Is the location occupied?
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Defines winning combinations
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [6,4,2],
  [0,3,6],
  [1,4,7],
  [2,5,8],
]

# Checks if position can be made
def valid_move?(board,position)
  position = position.to_i - 1
  if position.between?(0,8) == false
    false
  elsif position_taken?(board,position) 
    false
  else
    true
  end
end

# Gathers input from player. If move passes other methods, #turn calls #move.
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

# Returns how many turns have passed.
def turn_count(board)
  count = 0
  board.each do |spot|
    if (spot == "X") || (spot == "O")
      count += 1
    end
  end
  count
end

# Returns the symbol for the person who's turn it is.
def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

# Determines if a winning array set is occupied on the board.
# Winning combo that matches the Xs on the board
def won?(board)
  WIN_COMBINATIONS.detect do |win_array|
  win_array.all?{|spot| board[spot] == "X"} || win_array.all?{|spot| board[spot] == "O"}
  end
end

# Determines if the winning combinations have all been occupied.
# All WIN_COMBINATIONS must be #position_taken == true
def full?(board)
  WIN_COMBINATIONS.all? do |win_array|
    win_array.all?{|spot| position_taken?(board, spot)}
  end
end

# Determines if there is a draw/stalemate.
# Must be no winner
def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end

# Determines if the game is over.
# Must have winner or draw
def over?(board)
  if won?(board) || draw?(board)
    true
  else
    false
  end
end

# Returns the winning character.
def winner(board)
  if won?(board)
    combo = WIN_COMBINATIONS.detect{|win_array| win_array.all?{|spot| board[spot] == "X"} || win_array.all?{|spot| board[spot] == "O"}}
    answer = board[combo[0]]
  end
end
