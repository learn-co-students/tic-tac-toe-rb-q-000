
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6],
  [0,4,8],
  [1,4,7],
  [2,5,8],
  [2,4,6]
]

def display_board(board)
  separator = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "#{separator}"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "#{separator}"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, character)
  index = position.to_i - 1
  board[index] = character
  return board
end

def position_taken?(board, position)
  cell = board[position]
  if cell == " " || cell == "" || cell == nil
    return false
  elsif cell == "X" || cell == "O"
    return true
  end
end

def valid_move?(board, position)
  unless position.to_i.between?(1,9)
    return false
  end

  index = position.to_i - 1

  if position_taken?(board, index)
    return false
  else
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip

  if valid_move?(board, position)
    display_board(move(board, position, current_player(board)))
  else
    turn(board)
  end
end

def turn_count(board)
  arr = board.select { |e| e == "X" || e == "O"}
  return arr.count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect { |arr|
    unless arr.class == "Array"
      false
    end

     ((board[arr[0]] == "X" && board[arr[1]] == "X" && board[arr[2]] == "X") ||
     (board[arr[0]] == "O" && board[arr[1]] == "O" && board[arr[2]] == "O")) ?
     true : false
  }
end

def full?(board)
  board.all? { |e| e == "X" || e == "O" }
end

def draw?(board)
  won = won?(board)
  full = full?(board)
  if !won && full
    return true
  elsif (!won && !full) || won
    return false
  end
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  arr = won?(board)
  arr ? board[arr[0]] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end
