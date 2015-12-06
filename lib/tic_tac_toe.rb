# Helper Methods

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
    [0, 1, 2], # top_row_win
    [3, 4, 5], # middle_row_win
    [6, 7, 8], # bottom_row_win
    [0, 3, 6], # left_col_win
    [1, 4, 7], # middle_col_win
    [2, 5, 8], # right_col_win
    [0, 4, 8], # left_diag_win
    [2, 4, 6]  # right_diag_win
  ]

# Define board array here
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

# Define #display_board that accepts a board and prints out the current state.
def display_board(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Define #move method here!
def move(board, position, value = current_player)
  board[position.to_i - 1] = value
end
#move(board, 0, "X")

# Define #position_taken? method here
def position_taken?(board, position)
  if (board[position] == "X") || (board[position] == "O") ? true : false
    true
  else board[0 - 8] == " "
    false
  end
end

# Define #valid_move? method here
def valid_move?(board, position)
  !position_taken?(board, position.to_i - 1) && position.to_i.between?(1, 9)
end

# Define #turn method here
def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position, current_player(board))
    display_board(board)
  else
    until valid_move?(board, position) == true
      puts "Invalid move! Try again!"
      turn(board)
      break
    end
  end
end

# Define #turn_count method here
def turn_count(board)
  counter = 0
  board.each do |char|
    if char == "X" || char == "O"
      counter += 1
    end
  end
  counter
end

# Define #current_player method here
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

# Define #won? method here
def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
    win_combo.all? {|win_play| board[win_play] == "X"} || win_combo.all? {|win_play| board[win_play] == "O"}
  end
end

# Define #full? method here
def full?(board)
  board.all? do |full|
    full == "X" || full == "O"
  end
end

# Define #draw? method here
def draw?(board)
  if won?(board)
    return false
  else
    board.all? do |draw|
      draw == "X" || draw == "O"
    end
  end
end

# Define #over? method here
def over?(board)
  return :won? if won?(board)
  return :draw? if draw?(board)
  false
end

# Define #winner method here
def winner(board)
  if won?(board)
    if board[won?(board)[0]]  == "X"
       return "X"
    elsif board[won?(board)[0]] == "O"
       return "O"
    end
 else
   return nil
 end
end

# Define your #play method here
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