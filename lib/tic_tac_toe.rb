require 'pry'
WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player)
  board[location - 1] = current_player
end

def position_taken?(board, location)
  board[location.to_i] != " " && board[location.to_i] != ""
end

def valid_move?(board, position)
  if !position.to_i.between?(1,9)
    return false
  elsif position_taken?(board, position.to_i - 1) 
    return false
  else
    return true
  end
end

def current_player(board)
  turn_count(board) % 2 == 1 ? (return "O") : (return "X")
end

def turn(board)
  y = current_player(board)
  x = gets.strip
  puts "Please enter 1-9:"
  if !valid_move?(board, x.to_i)
    turn(board)
  else
    move(board, x.to_i, y)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space != " "
      count += 1
    end
  end
  return count
end



def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
 
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end
  end
end

def full?(board)
  if board.all?{|i| (i == "X") || (i == "O")}
    true
  else 
    false
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else 
    false
  end
end

def winner(board)
  if the_winner_combo = won?(board)
    board[the_winner_combo.first]
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
