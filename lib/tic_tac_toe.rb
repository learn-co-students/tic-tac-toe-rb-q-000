require 'pry'

# Define your WIN_COMBINATIONS constant
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

# code your move method here!
def move(board, pos, mark="X")
  board[pos.to_i-1] = mark
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  until valid_move?(board, input)
    puts "Please enter 1-9:"
    input = gets.strip
  end
  move(board, input, current_player(board))
  display_board(board)
end

def turn_count(board)
  count = 0
  index = 0
  board.each do |p| 
    count += 1 if position_taken?(board, index)
    index += 1
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def empty?(board)
  board_check = []
  index = 0
  board.each do |b|
    board_check << position_taken?(board, index)
    index += 1
  end
  board_check.none?
end

def full?(board)
  board_check = []
  index = 0
  board.each do |b|
    board_check << position_taken?(board, index)
    index += 1
  end
  board_check.all?
end

def won?(board)
  
  return nil if empty?(board)
  
  WIN_COMBINATIONS.each do |combo|
    board_check = []
    board_check << board[combo[0]]
    board_check << board[combo[1]]
    board_check << board[combo[2]]

    if board_check.all? {|pos| pos == "X"}
      return combo
    elsif board_check.all? {|pos| pos == "O"}
      return combo
    end

  end

  false
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
  win_combo = won?(board)
  return nil unless win_combo
  board[win_combo[0]]
end




# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end
  
  if won?(board)
    if winner(board) == "X"
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
  elsif draw?(board)
    puts "Cats Game!"
  end
end