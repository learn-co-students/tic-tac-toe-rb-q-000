# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def turn_count(board)
  count = 0
  board.each do |i|
    count += 1 if i == "X" || i == "O"
  end
  count
end

def turn(board)
  display_board(board)
  puts "Please enter 1-9:"
  position = gets.strip
  
  if valid_move?(board, position) 
    move(board, position, current_player(board))
    display_board(board) 
  else
    turn(board)
  end
end

def move (board, position, token="X")
  board[position.to_i - 1] = token
end

def valid_move?(board, position)
  position = position.to_i - 1
  if position_taken?(board, position) == false && position.between?(0, 8) == true
    true
  else
    false
  end
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    combo.all? { |i| board[i] == "X" } || 
    combo.all? { |i| board[i] == "O" }
  end
end

def full?(board)
  board.any? { |position| position == " " } ? false : true
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
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

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
    [0, 1, 2], # top-row
    [3, 4, 5], # middle-row
    [6, 7, 8], #bottom-row
    [0, 3, 6], #col-1
    [1, 4, 7], #col-2
    [2, 5, 8], #col-3
    [0, 4, 8], #diagonal-1
    [2, 4, 6]  #diagonal-2
  ]