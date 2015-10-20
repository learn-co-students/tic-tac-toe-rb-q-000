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
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, character = "X")
  board[position.to_i - 1] = character
end

def position_taken?(board, position)
  if board[position] != " "
    return true
  else
    return false
  end
end

def valid_move?(board, position)
  position = position.to_i - 1
  if !position.between?(0,8)
    return false
  elsif position_taken?(board, position)
    return false
  else 
    return true
  end
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
  counter = 0 
  board.each do | character |
    if character != " "
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
  WIN_COMBINATIONS.each do |win_combination|
    if win_combination.all? {|i| board[i] == "X"} ||  win_combination.all? {|i| board[i] == "O"}
      return win_combination
    end
  end
  return false
end

def full?(board)
  board.all? do |character|
    character != " "
  end
end

def draw?(board)
  if won?(board) || !full?(board)
    return false
  else 
    return true
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else 
    false
  end
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end
end


