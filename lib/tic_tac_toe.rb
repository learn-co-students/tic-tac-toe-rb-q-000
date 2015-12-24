def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char = "X")
  position = position.to_i
  position = position - 1
  board[position] = char
end

def valid_move?(board, position)
  #convert the user's string input to an integer
  position = position.to_i
  #convert the user's 1-9 position to the correct array position
  position = position - 1

  #check to verify the position is on the board
  if position.between?(0,8)
    #the position is on the board, check if it is taken
    if position_taken?(board, position)
      #the position is taken so it is not valid
      false
    else
      #the position is not taken so it is valid
      true
    end
  else
    #the position is not on the board
    false
  end
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    char = current_player(board)
    move(board, position, char)
  else
    puts "Please enter 1-9:"
    position = gets.strip
  end
  display_board(board)
end

def turn_count(board)
  #returns number of turns that have been played
  counter = 0
  board.each do |value|
    if value == "X" || value == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def three_moves?(board)
  if turn_count(board) >= 3
    true
  else
    false
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #Top Horizontal
  [3,4,5], #Middle Horizontal
  [6,7,8], #Bottom Horizontal
  [0,3,6], #Left Vertical
  [1,4,7], #Middle Vertical
  [2,5,8], #Right Vertical
  [0,4,8], #Top Left -> Bottom Right
  [2,4,6]  #Top Right -> Bottom Left
  ]

def won?(board)
  if three_moves?(board)
    WIN_COMBINATIONS.each do |winning_combo|
      if winning_combo.all?{|i| board[i] == "X"} || winning_combo.all?{|i| board[i] == "O"}
        return winning_combo
      end
    end
    return false
  end
end

def full?(board)
  board.none?{|v| v == " "} && board.none?{|v| v == ""} && board.none?{|v| v == nil}
end

def draw?(board)
  won?(board) == false && full?(board) == true
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    WIN_COMBINATIONS.each do |winning_combo|
      if winning_combo.all?{|i| board[i] == "X"}
        return "X"
      elsif winning_combo.all?{|i| board[i] == "O"}
        return "O"
      end
    end
  end
end