# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle Row
  [6,7,8], #Bottom Row
  [0,3,6], #Left Column
  [1,4,7], # Middle Column
  [2,5,8], # Right Column
  [0,4,8], # Diagaonal from top left
  [ 2,4,6], # Diagaonal from top right
  ]

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
display_board(board)

def move(board, location,player = "X")
  board[location.to_i-1] = player
end

def valid_move?(board, position)
 location = position.to_i - 1
  if position_taken?(board, location) == true || location.between?(0,9) == false
    return false
  else
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  if valid_move?(board, input)
    move(board,input.to_i, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |letter|
    if letter != " "
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board)%2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |wincomb|
    return wincomb if wincomb.all? do |position| board[position] == "X" end
    return wincomb if wincomb.all? do |position| board[position] == "O" end
  end
end

def full?(board)
  board.all? {|letter| letter != " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if letter_win = won?(board)
    board[letter_win.first]
  end
end

def play(board)
  while !over?(board)
turn(board)
end
if won?(board)
  puts "Congratulations #{winner(board)}!"
 elsif  draw?(board)
puts "Cats Game!"
end
end




