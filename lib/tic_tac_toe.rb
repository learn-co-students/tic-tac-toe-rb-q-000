# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end
# Define your WIN_COMBINATIONS constant
require 'pry'

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def won?(board)
  won_with_O?(board) || won_with_X?(board)
end

def won_with_O?(board)
  WIN_COMBINATIONS.detect do |win_array|
    win_array.all? do |win_index|
      board[win_index] == 'O'
    end
  end
end

def won_with_X?(board)
  WIN_COMBINATIONS.detect do |win_array|
    win_array.all? do |win_index|
      board[win_index] == 'X'
    end
  end
end

def full?(board)
  !board.detect do |position|
    position == " "
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won_with_O?(board)
    "O"
  elsif won_with_X?(board)
    "X"
  end
end

def valid_move?(board, position)
  if position_taken?(board, position.to_i - 1) || position.to_i.between?(1, 9) == false
    false
  else
    true
  end
end

def display_board(a)
  puts " #{a[0]} | #{a[1]} | #{a[2]} "
  puts "-----------"
  puts " #{a[3]} | #{a[4]} | #{a[5]} "
  puts "-----------"
  puts " #{a[6]} | #{a[7]} | #{a[8]} "
end

def move(board, position, char = "X")
  board[position.to_i - 1] = char
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.chomp
  if valid_move?(board, position)
    move(board, position, current_player(board))
  else
    puts "invalid"
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  board.select do |position|
    position == "O" || position == "X"
  end.length
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
