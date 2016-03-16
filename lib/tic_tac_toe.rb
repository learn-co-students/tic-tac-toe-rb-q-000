# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

# Display our TT board
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
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input,current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |square|
    count += square=="X"||square=="O" ? 1:0
  end
  count
end

def current_player(board)
  turns = turn_count(board)
  puts "Turns: #{turns}"
  turns%2==0 ? "X":"O"
end

#Method to determine if there is a winning combo on the board
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    combo.all?{|i| board[i]=="X"} || combo.all?{|i| board[i]=="O"}
  end
end

#To determine if the board is full
def full?(board)
  board.all?{|i| i=="X"||i=="O"}
end

#Determine if there is a draw on the board (fill & no winner)
def draw?(board)
  full?(board)&&!won?(board)
end

#over? accepts a board and returns true if the board has been won, is a draw, or is full.
def over?(board)
   full?(board)||won?(board)||draw?(board)
end

#winner method should accept a board and return the token, "X" or "O"
def winner(board)
  won?(board) ? board[won?(board).fetch(0)] : nil
end

# Define your play method below
def play(board)

  until over?(board)
    turn(board)
  end

  puts won?(board) ? "Congratulations #{winner(board)}!" : "Cats Game!"

end
