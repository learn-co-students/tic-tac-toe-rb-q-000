def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, current_player)
  board[position.to_i-1] = current_player
end

def position_taken?(board,position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  elsif board[position] == "X" || board[position] == "O"
    true
  end
end

def valid_move?(board, position)
  move = position.to_i-1
  if !position_taken?(board,move) && move.between?(0,8)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board,position) == false
    puts "Invalid move!  Please enter another move."
    turn(board)
  else
    move(board, position, current_player = current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |spot|
  if spot == "X" || spot == "O"
    count += 1
  end
  end
  count.to_i
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #Top row
  [3,4,5], #Middle row
  [6,7,8], #Bottom row
  [0,3,6], #Left column
  [1,4,7], #Middle column
  [2,5,8], #Right column
  [0,4,8], #Diagonal left
  [2,4,6]  #Diagonal right
]
# winning board combinations
def won?(board)
  WIN_COMBINATIONS.select do |location|
    if board[location[0]] == "X" && board[location[1]] == "X" && board[location[2]] == "X"
      return location
    elsif board[location[0]] == "O" && board[location[1]] == "O" && board[location[2]] == "O"
      return location
    end
  end

# empty board and draw
  WIN_COMBINATIONS.any? do |location|
   position_taken?(board,location[0])  && position_taken?(board,location[1])  && position_taken?(board,location[2])
   return false
 end
end


def full?(board)
  #draw and in progress
  WIN_COMBINATIONS.all? do |location|
    board[location[0]] != " " && board[location[1]] != " " && board[location[2]]  != " "
    end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  won?(board)
  if board.count("X") > board.count("O")
    "X"
  elsif board.count("X") < board.count("O")
    "O"
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  winner(board)
  if won?(board)
    puts ("Congratulations #{winner(board)}!")
  elsif draw?(board)
    puts ("Cats Game!")
  end
end
