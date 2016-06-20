
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

# Helper Methods
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

def move(board, position, current_player)
  board[position] = current_player
end

def position_taken?(board, location)
  if board[location] == " " || board[location] == "" || board[location] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |location|
    if location.upcase == "X" || location.upcase == "O"
      count = count + 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  won_status = false
  WIN_COMBINATIONS.each do |win_combination|
   pos_1 = board[win_combination[0]].upcase
   pos_2 = board[win_combination[1]].upcase
   pos_3 = board[win_combination[2]].upcase
   puts pos_1, pos_2, pos_3
   if pos_1 == "X" && pos_2 == "X" && pos_3 == "X"
     return win_combination
   elsif pos_1 == "O" && pos_2 == "O" && pos_3 == "O"
     return win_combination
   else
     won_status = false
   end
 end
 return won_status
end

def full?(board)
  board_full = board.all? do |location|
    location.upcase == "X" || location.upcase == "O"
  end
  board_full
end

def draw?(board)
  if won?(board)
    false
  else
    if full?(board)
      true
    else
      false
    end
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    return false
  end
end

def winner(board)
  player = nil
  if won?(board)
    win_combination = won?(board)
    player = board[win_combination[0]].upcase
    player
  else
    player = nil
  end
  player
end

def play(board)
  win_player = nil
  until over?(board)
    turn(board)
  end
  if won?(board)
    win_player = winner(board)
    puts "Congratulations #{win_player.upcase}!"
  else
    puts "Cats Game!"
  end
end
