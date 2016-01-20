WIN_COMBINATIONS = [
[0,1,2], # Top Row
[3,4,5], # Mid Row
[6,7,8], # Bot Row
[0,3,6], # Left Col
[1,4,7], # Mid Col
[2,5,8], # Right Col
[0,4,8], # L2R Diag
[2,4,6] # R2L Diag
]

def display_board(board)
  sep = "-----------"
  puts" #{board[0]} | #{board[1]} | #{board[2]} "
  puts sep
  puts" #{board[3]} | #{board[4]} | #{board[5]} "
  puts sep
  puts" #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = current_player(board))
  board[location.to_i.pred] = current_player
  puts board
end

def position_taken?(board, location)
  if board[location.to_i] != "X" && board[location.to_i] != "O"
    false
  else
    true
  end
end

def valid_move?(board, position)
  if position.to_i.between?(1,9) && !position_taken?(board,position.to_i.pred)
      true
  else
      false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board,position)
    move(board,position)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  filled_squares = []
  board.each do |square|
    if (square == "X" || square == "O")
      filled_squares<<square
    end
  end
  filled_squares.count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1=="X" && position_2=="X" && position_3 =="X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  false
end

def full?(board)
  if (board.count("X") + board.count("O") > 8)
    true
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  end
end

def winner(board)
  if won?(board) == false
    nil
  elsif board[won?(board)[0]] =="X"
    "X"
  elsif board[won?(board)[0]] == "O"
    "O"
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
