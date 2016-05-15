
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, token)
  board[position.to_i - 1] = token
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil 
    return false
  else
    return true
  end
end

def valid_move?(board, position)
  position = position.to_i - 1
  if position.to_i.between?(0,8) && !position_taken?(board, position)
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.chomp
  token = current_player(board)
  if valid_move?(board, position)
    move(board, position, token)
  else
    turn(board) 
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "O" || position == "X"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.each do |combo|
    # Finds the values combinations of winning game
    win_index_1 = combo[0] 
    win_index_2 = combo[1]
    win_index_3 = combo[2]

    # Finds the boards values of winning combo slots
    posistion_1 = board[win_index_1]
    posistion_2 = board[win_index_2]
    posistion_3 = board[win_index_3]

    # Compares the winning slots to the board
    if (posistion_1 == "X" && posistion_2 == "X" && posistion_3 == "X") || (posistion_1 == "O" && posistion_2 == "O" && posistion_3 == "O")
      # returns the winning combo
      return combo
    end
  end
  return false
end

def full?(board)
  board.none? do |empty|
    empty == " "
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
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
  else
    puts "Cats Game!"
  end
end


WIN_COMBINATIONS = [
  [0, 1, 2], # top row
  [3, 4, 5], # middle row
  [6, 7, 8], # bottom row
  [0, 3, 6], # left col
  [1, 4, 7], # middle col
  [2, 5, 8], # right col
  [0, 4, 8], # diag 1
  [6, 4, 2] # diag 2
]
