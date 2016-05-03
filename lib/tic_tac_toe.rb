WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8],  # Bottom row
  [0,3,6], # First Column
  [1,4,7], # Second Column
  [2,5,8], # Third Column
  [0,4,8], # Diagonal left to right
  [2,4,6]  # Diagonal right to left
]

# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# move
def move(board, location, current_player)
  board[location-1] = current_player
end

# position_take?
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

# valid_move?
def valid_move?(board, location)
  location = location.to_i - 1
  location.between?(0,8) && !position_taken?(board, location)? true : false
end

#turn
def turn(board)
  puts "Please enter a position 1-9:"
  input = gets.strip
  location = input.to_i
  if valid_move?(board, location)
    move(board, location, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# turn_count
def turn_count(board)
  turn_counter = 0
  board.each do |spot|
    turn_counter += 1 if position_taken?(board, board.index(spot))
  end
  return turn_counter
end

# current_player
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

# won?
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
      return combo
    elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
      return combo
    end
  end
  return false
end

# full?
def full?(board)
  board.all? {|position| position_taken?(board, board.index(position))}
end

# draw?
def draw?(board)
  true if !won?(board) && full?(board)
end

# over?
def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

# winner
def winner(board)
  if won?(board) && board[won?(board)[0]] == "X"
    return "X"
  elsif won?(board) && board[won?(board)[0]] == "O"
    return "O"
  else
    return nil
  end
end

# play
def play(board)
  until over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
