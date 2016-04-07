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

def move(board, position, player = "X")
  position = position.to_i - 1
  board[position] = player
end

def position_taken?(board, position)
  if board[position.to_i] == " " || board[position.to_i] == "" || board[position.to_i] == nil
    return false
  elsif board[position.to_i] == "X" || board[position] == "O"
    return true
  end
end

def valid_move?(board, position)
  if position.to_i > 9 || position.to_i < 1
    return false
  elsif position_taken?(board, position.to_i-1) == false
    return true
  else
    return false
  end
end

def turn(board)
  display_board(board)
  puts "Please enter 1-9:"
  position = gets.strip
  until valid_move?(board, position) == true
    puts "invalid"
    position = gets.strip
  end
  player = current_player(board)
  move(board, position, player)
end  

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn == "O" || turn == "X"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"  
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    position_1 = board[win_combo[0]]
    position_2 = board[win_combo[1]]
    position_3 = board[win_combo[2]]
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combo
    end
  end
  return false
end

def full?(board)
  if board.detect{|i| i == " "} == " "
   return false
  end
  return true
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  elsif won?(board) == false && full?(board) == false
    return false
  elsif won?(board) != false
    return false
  end
end

def over?(board)
  if won?(board) != false || full?(board) == true || draw?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) != false
    win_combo = won?(board)
    board[win_combo[0]]
  elsif won?(board) == false 
    return nil
  end
end

def play(board)
  until over?(board) == true
  turn(board)
  end
    if winner(board) == "X"
      puts "Congratulations X!"
    elsif winner(board) == "O"
      puts "Congratulations O!"
  elsif draw?(board) == true
    puts "Cats Game!"
  end
end



