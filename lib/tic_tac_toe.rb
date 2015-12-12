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

def display_board(array)
  puts " #{array[0]} | #{array[1]} | #{array[2]} "
  puts "-----------"
  puts " #{array[3]} | #{array[4]} | #{array[5]} "
  puts "-----------"
  puts " #{array[6]} | #{array[7]} | #{array[8]} "
end

def move(array, position, value="X")
  array[position.to_i - 1] = value
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
  position_taken?(board, position) == false && position.between?(0, board.length)
end

def move(board, position, token="X")
  position = position.to_i - 1
  board[position] = token
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  board.count { |i| i != " " }
end

def current_player(board)
  return turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if ((board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X") || 
      (board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"))
      return win_combination
    end
  end
  return false
end

def full?(board)
  board.none? { |i| i == " " }
end


def draw?(board)
  return won?(board) == false && full?(board) ? true : false
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  return won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
  input = gets.strip
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
