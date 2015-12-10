WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
  ]

def play(board)
  while !over?(board)
    mark = current_player(board)
    turn(board, mark)
  end
  if draw?(board)
    puts "Cats Game!"
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  end
  if winner(board) == "O"
    puts "Congratulations O!"
  end
end

def display_board(array)
  puts " #{array[0]} | #{array[1]} | #{array[2]} "
  puts "-----------"
  puts " #{array[3]} | #{array[4]} | #{array[5]} "
  puts "-----------"
  puts " #{array[6]} | #{array[7]} | #{array[8]} "
end

def move(board, position, mark)
  board[(position.to_i)-1] = mark
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, position)
  if position == "invalid"
    return false
  end
  position = (position.to_i) - 1
  if position <= 8
    if position_taken?(board, position)
      return false
    else
      return true
    end
  else
      return false
  end
end

def turn(board, mark="X")
  puts "Please enter 1-9:"
  input = gets.strip
  while !valid_move?(board, input)
    puts "Please enter 1-9:"
    input = gets.strip
  end
  move(board, input, mark)
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |mark|
    if mark == "X" || mark == "O"
      counter += 1
    end
  end
    return counter
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_pos1 = combo[0]
    win_pos2 = combo[1]
    win_pos3 = combo[2]

    position1 = board[win_pos1]
    position2 = board[win_pos2]
    position3 = board[win_pos3]

    if (position1 == "X" && position2 == "X" && position3 == "X") || (position1 == "O" && position2 == "O" && position3 == "O")
      return combo
    end
  end
  return false
end

def full?(board)
  !board.any?{ |i| i == " " || i.nil? }
end

def draw?(board)
  if full?(board)
    if !won?(board)
      return true
    else
      return false
    end
  elsif !won?(board)
    return false
  else
    return false
  end
end

def over?(board)
  if !draw?(board)
    if !won?(board)
      return false
    else
      return true
    end
  else
    return true
  end
end

def winner(board)
  if !won?(board)
    return nil
  else
    return board[won?(board)[0]]
  end
end