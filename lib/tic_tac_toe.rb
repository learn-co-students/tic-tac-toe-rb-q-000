WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, character = "X")
  board[position.to_i - 1] = character
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  elsif board[position] == "X" || board[position] == "O"
    true
  end
end

def valid_move?(board, position)
  position = position.to_i - 1
  position.between?(0, 8) && !position_taken?(board, position)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp

  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    until valid_move?(board, input) == true
      turn(board)
      break
    end
  end

  display_board(board)
end

def turn_count(board)
  board.count {|x| x == "O" || x == "X"}
end

def current_player(board)
  tc = turn_count(board)
  if tc.even?
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |x|
    (board[x[0]] == "X" &&
     board[x[1]] == "X" &&
     board[x[2]] == "X") ||
    (board[x[0]] == "O" &&
     board[x[1]] == "O" &&
     board[x[2]] == "O") &&
    position_taken?(board, x[0])
  end
end

def full?(board)
  board.all? {|x| x == "X" || x == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  (won?(board) || draw?(board)) || full?(board)
end

def winner(board)
  winner = won?(board)
  if won?(board)
    board[winner[0]]
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