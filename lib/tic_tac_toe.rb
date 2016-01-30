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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "----------- "
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, value = "X")
  position = position.to_i - 1
  board[position] = value
end

def position_taken? (board, position)
  if board[position] == "" || board[position] == " " || board[position] == nil
    return false
  else
    return true
    end
end

def valid_move?(board, position)
  position = position.to_i - 1
  if position_taken?(board, position) == false && position.between?(0,8) == true
  return true
  else
  return false
  end
end

def move(board, position, value = "X")
  position = position.to_i - 1
  board[position] = value
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
until valid_move?(board, position) == true
puts "Please enter 1-9:"
position = gets.strip
end
  move(board, position, value = "X")
display_board(board)
end

def turn2(board)
  puts "Please enter 1-9:"
  position = gets.strip
until valid_move?(board, position) == true
puts "Please enter 1-9:"
position = gets.strip
end
  move(board, position, value = "O")
display_board(board)
end

def turn_count(board)
  count = board.select do |position|
    position == "X" || position == "O"
  end
  return count.length
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
   WIN_COMBINATIONS.find do | win_combination |

     win_index_1 = win_combination[0]
     win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
     position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    else
      false
end
end
end


def full?(board)
  board.all? do |index|
    index == "X" ||index == "O"
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if full?(board) == true || won?(board) == true || draw?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    nil
  end
end

def play(board)
until won?(board) || draw?(board) || over?(board)
  if current_player(board) == "X"
  turn(board)
  else
  turn2(board)
  end
end
if draw?(board)
  puts "Cats Game!"
elsif winner(board) == "X"
  puts "Congratulations X!"
else
  puts "Congratulations O!"
end
end
