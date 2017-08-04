WIN_COMBINATIONS = [
  [0, 1, 2], # Top row = WIN_COMBINATIONS[0]
  [3, 4, 5], # Middle row = WIN_COMBINATIONS[1]
  [6, 7, 8], # Bottom row = WIN_COMBINATIONS[2]
  [0, 3, 6], # Left column = WIN_COMBINATIONS[3]
  [1, 4, 7], # Middle column = WIN_COMBINATIONS[4]
  [2, 5, 8], # Right column = WIN_COMBINATIONS[5]
  [0, 4, 8], # Left-to-right Diagonal = WIN_COMBINATIONS[6]
  [2, 4, 6] # Right-to-left Diagonal = WIN_COMBINATIONS[7]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0, 8)
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
    counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  character = current_player(board)
    if valid_move?(board, index)
      move(board, index, character)
      display_board(board)
    else
      puts "This move is invalid. Please enter a number from 1-9 for a space that isn't already taken."
      turn(board)
    end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
    board[win_combo[0]] == board[win_combo[1]] && 
    board[win_combo[1]] == board[win_combo[2]] && 
    position_taken?(board, win_combo[0])
  end
end

def full?(board)
  board.all? {|character| character == "X" || character == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
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
  else
    puts "I can't even tell what happened!"
  end
end