def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))   ### added third argument
  else
    turn(board)
  end
  display_board(board)
  if won?(board)
    return won?(board)
  end
end

def turn_count(board)
  counter = 0

  board.each do |position|
    if position != " "
      counter += 1
    end
  end

  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def board_empty?(board)
  board.each do |position|
    if position == "X" || position == "O"
      return false
    end
  end
  return true
end

def three_in_a_row?(board, combo, mark)
  combo.each do |position|
    if board[position] != mark
      return false
    end
  end
  return combo
end

def full?(board)
  board.each do |position|
    if position != "X" && position != "O"
      return false
    end
  end
  return true
end

def won?(board)
  if board_empty?(board)
    return false
  end
  PLAYERS.each do |mark|
    WIN_COMBINATIONS.each do |combo|
      if three_in_a_row?(board, combo, mark)
        return combo
      end
    end
  end
  return false
end

def draw?(board)
  if full?(board)
    if !won?(board)
      return true
    end
  end
  return false
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  end
  return false
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
  return nil
end

def play(board)
  #result = nil
  until over?(board)
    turn(board)
    if won?(board)
      break
    end
  end
=begin
  if won?(board)
    result = winner(board)
  end
=end
  if won?(board)
  #if result == "X" || result == "O"
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end


=begin
  result = nil
  9.times do
    result = turn(board)
    if result.kind_of?(Array)
      break
    end
  end

  puts "GAME OVER"
  #puts "winner is #{board[result[0]]}"
  puts "Congratulations #{board[result[0]]}!"
  puts "result is #{result}"
=end

end


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

PLAYERS = ["X", "O"]