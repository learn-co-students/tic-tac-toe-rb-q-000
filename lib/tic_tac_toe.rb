def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

def valid_move?(board, pos)
  pos.to_i.between?(1,9) && !position_taken?(board, pos.to_i-1)
end

def won?(board)
WIN_COMBINATIONS.detect do |arr| 
 if board[arr[0]] == "X" && board[arr[1]] == "X" && board[arr[2]] == "X"
   arr
 elsif board[arr[0]] == "O" && board[arr[1]] == "O" && board[arr[2]] == "O"
   arr
 else
   false
 end
end 
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

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
  # Creates a stop on RSpec
  # !(board[location].nil? || board[location] == "")
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def move(board, location, player = "X")
  board[location.to_i-1] = player
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
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