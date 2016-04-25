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

def move(board, position, player)
  board[position.to_i - 1] = player
end

def position_taken?(board, position)
  if board[position.to_i] == " "
    return false
  else
    return true
  end
end

def valid_move?(board, position)
  if position.to_i.between?(1, 9)
    if position_taken?(board, position.to_i - 1)
      return false
    else
      return true
    end
  else
    return false
  end
end

def turn(board)
  player = current_player(board)
  puts "Choose a position 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position, player)
  else
    puts "invalid"
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |i|
    if i != " "
      count += 1
    end
  end
  return count
end

def current_player(board)
  turn = turn_count(board)
  if turn == 0 || turn.even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  if board == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    return false
  elsif
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

      if position_1 != " " && position_1 == position_2 && position_1 == position_3
        return win_combination
      end
    end
  else 
    return false
  end
end

def draw?(board)
  board.any? do |space|
    if space == " "
      return false
    end
  end
  if won?(board)
    return false
  else
    return true
  end
end

def full?(board)
  if board.any?{ |i| i == " "}
    return false
  else
    return true
  end
end

def over?(board)
  if full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    player = won?(board)
    return board[player[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board) || won?(board) || draw?(board)
    puts "\n"
    display_board(board)
    puts "\n"
    turn(board)
  end
  puts "\n"
  display_board(board)
  puts "\n"
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cats Game!"
  end
end