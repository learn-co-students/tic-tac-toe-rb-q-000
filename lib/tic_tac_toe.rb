WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
 index = input.to_i - 1
 index.to_i
end

def move(board, index, value)


if value == "O" || current_player(board) == "O" 
  value = "O"
board[index] = value
elsif value == "X" || current_player(board) == "X" 
  value = "X"
board[index] = value


  end
  end

def valid_move?(board, index)
  if position_taken?(board, index) == false && index < 9 && index > -1
    true
  else false
  end
end

def position_taken?(board, index)
  if board[index] == "X"
    true
    elsif board[index] == "O"
    true 
  else false 
  end
  end

def turn(board)
input = gets.strip.to_i
prompt = puts "Please enter 1-9:"
  prompt
  input
  index = input_to_index(input)

  if valid_move?(board, index) == true
    move(board, index, value = "X")
    display_board(board)
  else gets.strip.to_i
  end
end 


def turn_count(board)
  x = 0
  o = 0
  

  board.each {|sym| 
    if sym == "X"
      x += 1
    elsif sym == "O"
      o += 1
    end
  }
  x + o
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else "O"
  end
  end

  def won?(board)
combo = 0
while combo < WIN_COMBINATIONS.length
  current = WIN_COMBINATIONS[combo]
  test_array = []
  index = 0
  while index < current.length
    test_array << board[current[index]]
    index += 1
  end
  if test_array.all?{|i| i == "X"} == true
  return WIN_COMBINATIONS[combo]
  elsif test_array.all?{|j| j == "O"} == true
  return WIN_COMBINATIONS[combo]
end
  combo += 1
end
false
  end

def full?(board)
  if board.any?{|space| space == " "} == true
    false
  else true
  end
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    true
  elsif won?(board) == false && full?(board) == true
    true
  else false
  end
  end

def over?(board)
  if full?(board) == false
    false
  else true
  end
end

def winner(board)
  combo = 0
while combo < WIN_COMBINATIONS.length
  current = WIN_COMBINATIONS[combo]
  test_array = []
  index = 0
  while index < current.length
    test_array << board[current[index]]
    index += 1
  end
  if test_array.all?{|i| i == "X"} == true
  return "X"
  elsif test_array.all?{|j| j == "O"} == true
  return "O"
end
  combo += 1
end
return nil
  end

def play(board)

i = 0
while i < 9
if won?(board) == false && draw?(board) == false && over?(board) == false
  turn(board)
elsif won?(board) == true || over?(board) == true
    break
  end
  i += 1
end

    if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
    else puts "Cats Game!"
    end
end


