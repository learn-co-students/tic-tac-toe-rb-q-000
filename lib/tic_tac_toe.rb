WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

def display_board(b)
  puts " #{b[0]} | #{b[1]} | #{b[2]} \n-----------\n #{b[3]} | #{b[4]} | #{b[5]} \n-----------\n #{b[6]} | #{b[7]} | #{b[8]} "
end

def move(board,idx,token="X")
  board[idx.to_i - 1] = token
  return board
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    return false
  elsif board[position] == "X" || board[position] == "O"
    return true
  end
end

def valid_move?(board,position)
  position = position.to_i
  if position > 9 || position < 1
    return false
  elsif !position_taken?(board,position - 1)
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board,position)
    move(board,position,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  count = turn_count(board)
  if count % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  win = WIN_COMBINATIONS.detect{|i| board[i[0]] + board[i[1]] + board[i[2]] == "XXX" || board[i[0]] + board[i[1]] + board[i[2]] == "OOO"}
  if !win
    return false
  else
    win
  end
end

def full?(board)
  board.all?{|i| i == "X" || i == "O"}
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  end
end

def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  if !won?(board)
    nil
  else board[won?(board)[0]]
  end
end

=begin
until the game is over
  take turns
end

if the game was won
  congratulate the winner
else if the game was a draw
  tell the players it has been a draw
end
=end

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end