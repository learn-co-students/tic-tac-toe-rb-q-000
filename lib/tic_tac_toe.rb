WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    cur = current_player(board)
    move(board, index, cur)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn != " "
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
  win_combo = false
  WIN_COMBINATIONS.each do |arr|
    position_1 = arr[0]
    position_2 = arr[1]
    position_3 = arr[2]

    wpos1 = board[position_1]
    wpos2 = board[position_2]
    wpos3 = board[position_3]
    if (wpos1 == "X" && wpos2 == "X" && wpos3 == "X") || (wpos1 == "O" && wpos2 == "O" && wpos3 == "O")
      win_combo = arr
    end
  end
  return win_combo
end

def full?(board)
  if board.all? { |e| e == "X" || e == "O" }
    return true
  end
end
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  if (won?(board) || full?(board) || draw?(board))
    return true
  else
    return false
  end
end

def winner(board)
  if !won?(board)
  return nil
elsif won?(board)
    arr = won?(board)
    pos = arr[1]
    return board[pos]
 end
end

def play(board)
  counter = 1
  while counter < 10 && !over?(board)
    turn(board)
    counter += 1
  end
  if won?(board)
    winnerp = winner(board)
    puts "Congratulations #{winnerp}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
