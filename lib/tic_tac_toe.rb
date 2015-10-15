WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
  ]


def display_board(board)
  puts " " + board[0] + " | " + board[1] + " | " + board[2] + " "
  puts "-" * 11
  puts " " + board[3] + " | " + board[4] + " | " + board[5] + " "
  puts "-" * 11
  puts " " + board[6] + " | " + board[7] + " | " + board[8] + " "
end

def move(board_array, location, character="X")
  location = location.to_i
  location = location -= 1
  board_array[location] = character
  return board_array
end

def position_taken?(board, position)
  if ((board[(position)] == " ") || (board[position] == "") || (board[position] == nil))
    return false
  else
    return true
  end
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.chomp
  if valid_move?(board, position)
    move(board, position, current_player(board))
    display_board(board)
  else
    puts "Sorry that's not available. Please try again"
    turn(board)
  end
end

def turn_count(board)
  x_count = board.count("X")
  o_count = board.count("O")
  total_turns = (x_count + o_count)
  return total_turns
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    combo.all? {|choice| board[choice] == "X"} || combo.all? {|choice| board[choice] == "O"}
  end
end

def full?(board)
  if board.none?{|position|position == " "} then true
  end
end

def draw?(board)
  if (full?(board) && !won?(board)) then true
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board) then true
  end
end

def winner(board)
  unless won?(board)
    return nil
  end
  if board[won?(board)[0]] == "X"
    return "X"
  elsif board[won?(board)[0]] == "O"
    return "O"
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
  end
end