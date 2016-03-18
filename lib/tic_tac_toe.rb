WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Center column
  [2,5,8], # Right column
  [0,4,8], # Right diagonal
  [2,4,6] # Left diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board, position)
  !(board[position].nil? || board[position].empty? || board[position] == " ")
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
    board[win_combo[0]].eql?(board[win_combo[1]]) &&
    board[win_combo[1]].eql?(board[win_combo[2]]) &&
    position_taken?(board, win_combo[0])
  end
end

def winner(board)
  winning_combo = won?(board)
  # Return winner ("O" or "X").
  return board[winning_combo.first] if winning_combo
end

def full?(board)
  board.all? do |board_token|
    board_token == "X" || board_token == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i - 1)
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def move(board, position, current_player)
  board[position.to_i - 1] = current_player
end

def turn_count(board)
  board.count do |player_token|
    player_token == "X" || player_token == "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
