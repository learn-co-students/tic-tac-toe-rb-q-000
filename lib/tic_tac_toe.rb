require 'pry'
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

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index.to_i] = current_player
end

def position_taken?(board, location)
  if board[location] != " " && board[location] != ""
    true
  else
    false
  end
end

def valid_move?(board, index)
  if index.between?(0,8) && !position_taken?(board,index)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  input = input.to_i - 1
  if valid_move?(board, input)
    move(board,input,current_player(board))
  else
    puts "Please try a valid input!"
    display_board(board)
    turn(board)
  end
end

def won?(board)
  if WIN_COMBINATIONS.detect do |win_combo|
    if board[win_combo[0]] == "X" &&  board[win_combo[1]] == "X" && board[win_combo[2]] == "X"
      return win_combo
    elsif board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O"
      return win_combo
    end
  end
  else
    return false
  end
end

def full?(board)
  if board.detect do |i|
    if i == " "
      return false
    end
  end
  else
    true
  end
end

def draw?(board)
  if full?(board) && won?(board) == false
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board) && current_player(board) == "X"
    "O"
  elsif won?(board) && current_player(board) == "O"
    "X"
  end
end

def turn_count(board)
  board.count{|x| x if x == "X" || x == "O"}
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def play(board)
  while !over?(board) do
    display_board(board)
    turn(board)
  end
  display_board(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
