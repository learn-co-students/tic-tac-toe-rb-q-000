def display_board(board)
  print " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, value="X")
  board[position.to_i - 1] = value
end

def position_taken?(board, position)
  if board[position.to_i] == "" || board[position.to_i] == " " || board[position.to_i] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, position)
  if position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
    true
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

def turn_count(board)
  counter = 0
    board.each do |move|
      if (move == "X" || move == "O")
        counter += 1
      end
    end
return counter
end

def current_player(board)
  counter = 0
    board.each do |move|
      if (move == "X" || move == "O")
        counter += 1
      end
    end

  if (counter % 2 == 0)
    return "X"
  elsif (counter % 2 != 0)
    return "O"
  end
end

WIN_COMBINATIONS = [
 [0, 1, 2], #top row win
 [3, 4, 5], #middle row win
 [6, 7, 8], #bottom row win
 [0, 3, 6], #left row win
 [1, 4, 7], #middle_2 row win
 [2, 5, 8], #right row win
 [0, 4, 8], #diag l_r row win
 [2, 4, 6] #diag r_l row win
]

def won?(board)
  WIN_COMBINATIONS.each do |x|
    win_index_1 = x[0]
    win_index_2 = x[1]
    win_index_3 = x[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return x.to_a
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return x.to_a
  end
  end
  return nil
end

def full?(board)
  !board.any?{|x| x == " " || x == "" }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  combination = won?(board)
    if combination
      board[combination[0]]
    else
      return nil
    end
end


