# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  # ETC, an array for each win combination
]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  hr = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts hr
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts hr
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your move method here!
def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

# code your #valid_move? method here
def valid_move?(board, position)
  position = position.to_i - 1
  if (position.between?(0,8) && !position_taken?(board, position))
    true
  else
    false
  end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
# code your #position_taken? method here!
def position_taken?(board, position)
  if (board[position] == " " || board[position] == "" || board[position] == nil)
    false
  elsif (board[position] == "X" || board[position] == "O")
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  while (!valid_move?(board, position))
    puts "Please enter 1-9:"
    position = gets.strip
  end
  move(board, position, current_player(board))
  display_board(board)
  
end


def turn_count(board)
  counter = 0
  board.each do |x|
    if (x == "X"  || x == "O")
      counter += 1
    end
  end
  counter
end

def current_player(board)
  counter = turn_count(board)
  counter % 2 == 0 ? "X" : "O"
  
end

def won?(board)
  if (board.all? { |e| (e == " " || e == "")})
    false
  else
    WIN_COMBINATIONS.detect do |win_combination|
      win_combination.all? { |e| (board[e] == "X") } || win_combination.all? { |e| (board[e] == "O") }
    end
  end
end

def full?(board)
  board.all? { |e| (e == "X" || e == "O") }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    winner = board[won?(board)[1]]
  else
    nil
  end
  
end


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