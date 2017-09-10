# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS  = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]
#method that prints the current board representation based on the board argument passed to the method.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, position, character)
  board[position] = character
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  (index).between?(0, 8) &&
  !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  until valid_move?(board, index) == true
    puts "please try a valid move. Use an empty location 1 through 9"
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
  end
  character = current_player(board)
  move(board, index, character)
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |location|
    if location != " "
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) %2 == 0
    "X"
  else "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_index|
    board[win_index[0]] == board[win_index[1]] &&
    board[win_index[1]] == board[win_index[2]] &&
    position_taken?(board,win_index[0])
  end
end

def full?(board)
  board.all? do |position|
    position == "X" || position =="O"
  end
end

def draw?(board)
  over?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board)
end

def winner(board)
  if win_index = won?(board)
  board[win_index.first]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "dude...a tie means you both lost"
  elsif winner(board) == "X"
    puts "That X is so hot right now."
  else
    puts "Ohhhhhhhhhhhhhh snap!"
  end
end
