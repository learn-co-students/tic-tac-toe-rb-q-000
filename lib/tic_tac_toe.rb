#require 'pry'
#board = Array.new(9) {|i| " " }
# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    marker = current_player(board)
    move(board, position, marker)
  else
    turn(board)
  end
  display_board(board)
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


# Define your WIN_COMBINATIONS constant
 WIN_COMBINATIONS = [
   [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
   [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
  ]

def turn_count(board)
  count = 0
  (0..8).each do |i|
    count += 1 if position_taken?(board, i)
  end
  return count
end

def current_player(board)
  return "X" if turn_count(board) % 2 == 0
  return "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |row|
    return row if row.all? {|i| board[i] == "X"} || row.all? {|i| board[i] == "O"}
  end
  return false
end


def full?(board)
  #return false if won?(board)
  WIN_COMBINATIONS.all? do |row|
    row.all? {|i| position_taken?(board, i)}
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  win_row = won?(board)
  return board[win_row[0]] if win_row
end
