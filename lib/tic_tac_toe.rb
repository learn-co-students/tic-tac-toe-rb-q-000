WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  row_divider = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts row_divider
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts row_divider
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, character="X")
  location = location.to_i - 1
  board[location] = character
  return board
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position = position.to_i
  if (position.between?(1, 9) && !position_taken?(board, position-1)) 
    return true
  end
  return false
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if (valid_move?(board, position))
    move(board, position, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def current_player(board)
  count = turn_count(board)
  if (count % 2 == 0)
    return "X"
  else
    return "O"
  end
end

def turn_count(board)
  count = 0
  board.each do|spot|
    if (spot == "X" || spot == "O")
      count += 1
    end
  end
  return count
end

def won?(board)
  WIN_COMBINATIONS.each do|combo|
    index1 = combo[0]
    index2 = combo[1]
    index3 = combo[2]
    if (board[index1] == board[index2] && board[index2] == board[index3] && position_taken?(board, index1))
      return combo
    end
  end
  return false
end

def full?(board)
  (0..board.size-1).each do|i|
    if (!position_taken?(board, i)) 
      return false
    end
  end
  return true
end

def draw?(board)
  if (!won?(board) && full?(board))
    return true
  end
  return false
end

def over?(board)
  if (won?(board) || full?(board) || draw?(board))
    return true
  end
  return false
end

def winner(board)
  win_indices = won?(board)
  if (win_indices)
    return board[win_indices[0]]
  end
  return nil
end

def play(board)
  until (over?(board))
    turn(board)
  end

  if (won?(board))
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif (draw?(board))
    puts "Cats Game!"
  end
end