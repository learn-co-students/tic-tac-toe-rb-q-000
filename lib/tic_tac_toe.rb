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
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0,8)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  value = current_player(board)
  if valid_move?(board, index)
    move(board, index, value)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position != " "
      counter +=1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  elsif turn_count(board) % 2 == 1
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_index|
    if board[win_index[0]] != " " && board[win_index[0]] == board[win_index[1]] && board[win_index[1]] == board[win_index[2]]
      return win_index
    end
  end
  return false
end

def full?(board)
  board.all? do |i|
    i == "X" || i == "O"
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if !won?(board) && full?(board)
    return true
  elsif won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if win = won?(board)
    board[win.first]
  end
end

def play(board)
  until over?(board) || draw?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end
end
