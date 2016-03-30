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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, input, player = "X")
  board[input.to_i - 1] = player
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    return false
  elsif board[position] == "X" || board[position] == "O"
    return true
  end
end

def valid_move?(board, position)
  index = position.to_i-1
  if position_taken?(board, index) == true
    return false
  elsif position_taken?(board, index) == false
    if index > 8 || index < 0
      return false
    else return true
    end
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position, current_player(board))
    return display_board(board)
  else
  until valid_move?(board, position)
    puts "Invalid move, please try again."
    position = gets.strip
  end
move(board, position, current_player(board))
  display_board(board)
end
end

def turn_count(board)
  return board.reject{|i| i == " "}.length
end

def current_player(board)
  turn = turn_count(board)
  if turn.even?
    return "X"
  else return "O"
  end
end

def won?(board)
    if board == [" "," "," "," "," "," "," "," "," "]
      return false
    end
  WIN_COMBINATIONS.each do |win|
    if board[win[0]] == "X" && board[win[1]] == "X" && board[win[2]] == "X"
      return true
    elsif board[win[0]] == "O" && board[win[1]] == "O" && board[win[2]] == "O"
      return true
    else false
    end
  end
  return false
end

def full?(board)
  if board.any?{|value| value == " "}
    false
  else return true
  end
end

def draw?(board)
  if full?(board)
    if won?(board)
        return false
    else
        return true
    end
  else return false
  end
  return false
end

def over?(board)
  if won?(board)
    return true
  elsif draw?(board)
    return true
  else return false
  end
end

def winner(board)
  WIN_COMBINATIONS.each do |win|
    if board[win[0]] == "X" && board[win[1]] == "X" && board[win[2]] == "X"
      return "X"
    elsif board[win[0]] == "O" && board[win[1]] == "O" && board[win[2]] == "O"
      return "O"
    end
  end
  return nil
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

