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
  puts " #{array[0]} ""|"" #{array[1]} ""|"" #{array[2]} "
  puts "-----------"
  puts " #{array[3]} ""|"" #{array[4]} ""|"" #{array[5]} "
  puts "-----------"
  puts " #{array[6]} ""|"" #{array[7]} ""|"" #{array[8]} "
end

board = [" "," "," "," "," "," "," "," "," "]

def input_to_index (input)
  index = input.to_i - 1
end

def move (board,index,value)
  board[index] = value
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  empty = board.count(" ")
  turn = 9 - empty
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    value = current_player(board)
    move(board,index,value)
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |combo|
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X" ||
      board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
      true
  end
  end
end

def full?(board)
  board.all? do |position|
    position != " "
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  WIN_COMBINATIONS.find do |combo|
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
      return "X"
    elsif  board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
      return "O"
    end
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
