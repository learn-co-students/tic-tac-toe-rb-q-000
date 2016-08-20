# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
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
  [2,4,6]
]

def won?(board)
  wc = WIN_COMBINATIONS
  wc.each do |c|
    if position_taken?(board, c[0])
      if board[c[0]] == board[c[1]] && board[c[1]] == board[c[2]]
        return c
      end
    end
  end
  false
end

def full?(board)
  full = WIN_COMBINATIONS.all? do |wc|
    position_taken?(board, wc[0]) &&
    position_taken?(board, wc[1]) &&
    position_taken?(board, wc[2])
  end
end

def draw?(board)
  !won?(board) && full?(board)? true : false
end

def over?(board)
  won?(board) || full?(board) || draw?(board) ? true : false
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def turn_count(board)
  board.count("X") + board.count("O")
end

def current_player(board)
   turn_count(board) % 2 == 0 ? "X" : "O"
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player)
  board[location - 1] = current_player
end


def valid_move?(board, location)
  location.to_i.between?(1,9) && !position_taken?(board, location.to_i - 1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  location = input.to_i
  if valid_move?(board, location)
    move(board, location, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
