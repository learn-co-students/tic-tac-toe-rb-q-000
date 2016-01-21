WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = current_player(board))
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
    move(board, input)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count (board)
  count = 0
  board.each do |tile|
    tile == "X" || tile == "O" ? count += 1 : nil
  end
  count
end

def current_player (board)
  turn_count(board).even? ? "X" : "O"
end

def won? (board)
  WIN_COMBINATIONS.each do |condition|
    win_1 = condition[0]
    win_2 = condition[1]
    win_3 = condition[2]

    value_1 = board[win_1]
    value_2 = board[win_2]
    value_3 = board[win_3]

    if value_1 == "X" && value_2 == "X" && value_3 == "X"
      return condition
    elsif value_1 == "O" && value_2 == "O" && value_3 == "O"
      return condition
    end
  end
  false
end

def full? (board)
  board.all? do |tile|
    tile == "X" || tile == "O"
  end
end

def draw? (board)
  if won?(board)
    false
  elsif !won?(board) && full?(board)
    true
  end
end

def over? (board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end

def winner (board)
  if !won?(board)
    nil
  elsif board[won?(board)[0]] == "X"
    "X"
  elsif board[won?(board)[0]] == "O"
    "O"
  end
end

def play (board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end