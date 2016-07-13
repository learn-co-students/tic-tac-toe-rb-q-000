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

def input_to_index(input)
  input = input.to_i - (1)
  index = input
end

def move(board, index, player)
  def update_board_at_with(board, index, player)
    board[index] = player
  end
    update_board_at_with(board, index, player)
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else board[index] == "X" || board[index] == "O"
    return true
  end
end

def valid_move?(board, index)
  if position_taken?(board, index)
    return false
  end

  if index.between?(0, 8)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  if valid_move?(board, index)
    return move(board, index, current_player(board)) && display_board(board)
    else
      return turn(board)
  end
end

def turn_count(board)
  board.each do |count|
    return board.count { |x| x != " "}
  end
end

def current_player(board)
  if turn_count(board) % 2 == 0
    player_token = "X"
  else turn_count(board) % 2 == 1
    player_token = "O"
  return player_token
  end
end

def won?(board)
  if WIN_COMBINATIONS.each do |combo|

    combo_index_1 = combo[0]
    combo_index_2 = combo[1]
    combo_index_3 = combo[2]

    win_position_1 = board[combo_index_1]
    win_position_2 = board[combo_index_2]
    win_position_3 = board[combo_index_3]

    if win_position_1 == "X" && win_position_2 == "X" && win_position_3 == "X"
      return combo
    elsif win_position_1 == "O" && win_position_2 == "O" && win_position_3 == "O"
      return combo
    end
  end
  else
    return false
  end
end

def full?(board)
  if board.any? { |i| i == " " }
    return false
  elsif board.count{|i| i == 5}
    return true
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else won?(board)
    return false
  end
end

def over?(board)
  if draw?(board) || won?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
   if win_combo = won?(board)
     board[win_combo.first]
   end
end

def play(board)
  while !over?(board)
        turn(board)
    end
      if over?(board)
        puts "Congratulations #{winner(board)}!"
      end
      if draw?(board)
        puts "Cats Game!"
      end
  end
