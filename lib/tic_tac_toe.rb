# test methods > rspec spec/01_tic_tac_toe_spec.rb
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
WIN_COMBINATIONS = [
  [0, 1, 2], # Top row
  [3, 4, 5], # Middle row
  [6, 7, 8], # Bottom row
  [0, 3, 6], # Left row
  [1, 4, 7], # Middle row
  [2, 5, 8], # Right row
  [0, 4, 8], # Backslash \
  [2, 4, 6], # Forward slash /
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char = "X")
  board[position.to_i - 1] = char
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    return false
  elsif board[position] == "X" || board[position] == "O"
    return true
  else
  end
end

def valid_move?(board, position)
  if !position_taken?(board, position.to_i - 1) && (position.to_i - 1).between?(0, 9)
    return true
  else
    return false
  end
 end

def turn(board)
  puts "Where would you like to go?"
  puts "Please enter 1-9:"
  input = gets.strip
   if valid_move?(board, input) == true
      move(board, input)
      display_board(board)
   else
      puts "Sorry, that is not a valid move."
      turn(board)
  end
end

def play(board)
=begin
pseduo-code:
until the game is over
  take turns
end
if the game was won
  congratulate the winner
else if the game was a draw
  tell the players it has been a draw
=end
  # rspec spec/02_play_spec.rb
  counter = 0
  while counter < 9
    turn(board)
    counter += 1
  end
  if draw?(board) == true
    puts "This game was a draw!"
  elsif won?(board) == "X"
    puts "Congratulations player 'X'!"
  elsif won?(board) == "O"
    puts "Congratulations player 'O'!"
  end
end

def turn_count(board)
  counter = 0
  board.each do |place|
    if place == "X" || place == "O" then counter += 1 end
    end
  return counter
end

def current_player(board)
  if turn_count(board).even? then
    return "X"
  elsif turn_count(board).odd? then
    return "O"
  end
end

def won?(board)
  #return win combination indexes or nil
  #iterate over WIN_COMBINATIONS
=begin
WIN_COMBINATIONS = [
  [0, 1, 2], # Top row
  [3, 4, 5], # Middle row
  [6, 7, 8], # Bottom row
  [0, 3, 6], # Left row
  [1, 4, 7], # Middle row
  [2, 5, 8], # Right row
  [0, 4, 8], # Backslash \
  [2, 4, 6], # Forward slash /
  ]
=end
  WIN_COMBINATIONS.any? do |nested_array|
    if nested_array.all? { |index_position| board[index_position] == "X" } == true
      return nested_array
    elsif nested_array.all? { |index_position| board[index_position] == "O" } == true
      return nested_array
    else
    end
  end
end

def full?(board)
  #return true if all positions taken
  if board.all? do |token|
    token == "X" || token == "O"
    end
  return true
  else
  return false
  end
end

def draw?(board)
  #return true if no win and full, false if no win and not full, false if win
  if won?(board) == false && full?(board) == true
    then true
    elsif won?(board) == false && full?(board) == false
    then false
  elsif won?(board) == true
    then false
  end
end

def over?(board)
  #return true if board won, draw, or full
  if won?(board) == true
    return true
  elsif draw?(board) == true
    return true
  elsif full?(board) == true
    return true
  end
end

def winner(board)
  #return "X" or "O" winner
    if won?(board) == false
      return nil
    else
      if won?(board).all? { |nested_position| board[nested_position] == "X" }
        return "X"
      elsif won?(board).all? { |nested_position| board[nested_position] == "O" }
        return "O"
      end
    end
end