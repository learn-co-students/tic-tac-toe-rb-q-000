<<<<<<< HEAD
=======
#helper method
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

>>>>>>> d53b41c3507ebb66338d67252f5aa39d016158da
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
<<<<<<< HEAD
=======

def move(board, location, current_player)
  current_player(board)
  board[location.to_i - 1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, location)
  (location.to_i - 1).between?(0,8) && !position_taken?(board, location.to_i - 1)
end

def turn(board)
  puts "Please enter 1-9:"
  location = gets.strip
  if valid_move?(board, location)
    move(board, location, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.count("X") + board.count("O") do |board|
    counter += 1
  end
end

def current_player(board)
  turn_count(board)
  if (board.count("X") + board.count("O")).even?
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_conbination|
    win_index_1 = win_conbination[0]
    win_index_2 = win_conbination[1]
    win_index_3 = win_conbination[2]
    board[win_index_1] == board[win_index_2] && board[win_index_2] == board[win_index_3] && board[win_index_1] != " "
  end
end

def full?(board)
  board.none? {|position| position == " "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  win_conbination = won?(board)
  if win_conbination != nil
    winning_location = win_conbination[0]
    board[winning_location]
  else
    nil
  end
end

def play(board)
  current_player(board)
  turn(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  else
    until over?(board)

      play(board)
    end
  end
end
>>>>>>> d53b41c3507ebb66338d67252f5aa39d016158da

def move(board, input, current_player)
  board[input.to_i - 1] = current_player
end

def position_taken?(board, input)
  board[input] != " " && board[input] != ""
end

def valid_move?(board, input)
  (input.to_i - 1).between?(0,8) && !position_taken?(board, input.to_i - 1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  current_player = current_player(board)
  if valid_move?(board, input)
    move(board, input, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.count("X") + board.count("O") do |board| 
     counter += 1
  end
end

def current_player(board)
  turn_count(board)
  if (board.count("X") + board.count("O")).even?
    "X"
  else
    "O"
  end
end

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
  WIN_COMBINATIONS.detect do |win_conbination|
    win_index_1 = win_conbination[0]
    win_index_2 = win_conbination[1]
    win_index_3 = win_conbination[2]
    board[win_index_1] == board[win_index_2] && board[win_index_2] == board[win_index_3] && board[win_index_1] != " "
  end
end

def full?(board)
  board.none? {|position| position == " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  win_conbination = won?(board)
  if win_conbination != nil
    winning_location = win_conbination[0]
    board[winning_location]
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
  else draw?(board)
    puts "Cats Game!"
  end
end
