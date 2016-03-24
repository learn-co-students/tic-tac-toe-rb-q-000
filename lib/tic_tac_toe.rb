WIN_COMBINATIONS = [
[0, 1, 2], 
[3, 4, 5], 
[6, 7, 8], 
[0, 3, 6], 
[1, 4, 7], 
[2, 5, 8], 
[0, 4, 8], 
[2, 4, 6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player="X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
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
  board.each do |x|
    if x == "X" || x == "O"
      counter += 1
    else
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).even? == true
    "X"
  elsif turn_count(board) == 0
    "X"
  else
    "O"
  end 
end

def won?(board)
  win_index_1 = 0
  win_index_2 = 0
  win_index_3 = 0
  position_1 = 0
  position_2 = 0
  position_3 = 0
  WIN_COMBINATIONS.each do |x|
    win_index_1 = x[0]
    win_index_2 = x[1]
    win_index_3 = x[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return x
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return x
    end
  end
  false
end

def full?(board)
  if board.include?(" ") == true
    false
  else
    true
  end
end  

def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  elsif won?(board) == false && full?(board) == false
    false
  elsif won?(board) != false
    false
  end      
end

def over?(board)
  if won?(board) != false
    true
  elsif draw?(board) == true
    true
  elsif full?(board) == true
    true
  else
    false
  end
end

def winner(board)
  winner = won?(board)
  if won?(board) == false
  else
    #return x or o
    board[won?(board)[0]]
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end

  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) ==  true
    puts "Cats Game!"
  end
end







