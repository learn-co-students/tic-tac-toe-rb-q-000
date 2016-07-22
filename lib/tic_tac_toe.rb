WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # mid row
  [6,7,8], # bottom row
  [0,3,6], # left column
  [1,4,7], # mid column
  [2,5,8], # right column
  [0,4,8], # diagonal
  [2,4,6], # diagonal
]

def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (val)
  return val.to_i - 1
end

def move (board, idx, val)
  board[idx] = val
end

def position_taken? (board, idx)
  return (board[idx] == "X" || board[idx] == "O")
end

def valid_move? (board, idx)
  return (idx < 10 && idx >= 0) && !position_taken?(board, idx)
end

def turn_count (board)
  turns = 0
  board.each { |val|
    (turns += 1) if ["X","O"].include? val
  }
  return turns
end

def current_player (board)
  return (turn_count(board) % 2 == 0) ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  position = input_to_index(gets.chomp)

  until valid_move?(board, position)
    puts "Invalid response, Please enter 1-9:"
    position = input_to_index(gets.chomp)
  end

  move(board, position, current_player(board))
  display_board(board)
end

def won? (board)
  WIN_COMBINATIONS.each { |win_combo|
    if (board[win_combo[0]] == board[win_combo[1]]) && (board[win_combo[1]] == board[win_combo[2]]) && position_taken?(board, win_combo[0])
      return win_combo
    end
  }

  return false
end

def full? (board)
  return board.all? { |val| ["X","O"].include? val }
end

def draw? (board)
  return false if won?(board)
  return full?(board)
end

def over? (board)
  return (won?(board) || draw?(board))
end

def winner (board)
  return board[won?(board)[0]] if won?(board)
end


def play (board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
