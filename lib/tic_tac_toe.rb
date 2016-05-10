# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
[0,1,2], #top row
[3,4,5], #middle row
[6,7,8], # bottom row
[0,3,6], #first column
[1,4,7], #second column
[2,5,8], #third column
[0,4,8], #first diagonal
[2,4,6], #second diagonal
]

# Define display_board that accepts a board and prints
# out the current state. 
def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your move method here!
def move(board, position, character= current_player(board))
board[position.to_i - 1] = character
end

# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# code your #valid_move? method here
def valid_move?(board, position)
  position = position.to_i - 1
 if position_taken?(board, position) == false && position.to_i.between?(0, 8)
  return true
elsif position_taken?(board, position) == true
  return false
else 
  return false
end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position) == true
    move(board, position, char = current_player(board))
   elsif 
    until valid_move?(board, position) == true
    puts "Invalid move.  Please select an unoccupied position on the board."
    position = gets.strip
   end
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
     counter += 1
    end
  end
  return counter
 end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
  end

def won?(board)
 WIN_COMBINATIONS.detect do |wins|
    board[wins[0]] == board[wins[1]] &&
    board[wins[1]] == board[wins[2]] &&
    position_taken?(board, wins[0])
  end
end

def full?(board)
  board.all? {|p| position_taken?(board, p.to_i + 1)} ? true : false
end

def draw?(board)
  !won?(board) && full?(board) ?  true : false
end

def over?(board)
  won?(board) || full?(board) || draw?(board) ? true : false
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

def play(board)
  until over?(board)
      turn(board)
  end
      if won?(board) == true
      puts "Congratulations #{winner(board)}!"
      elsif draw?(board) == true
      puts "Cats Game!"
      end
end