# Helper Methods
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
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  turn_count=0
  board.each do |mark|
    if mark=="X"||mark=="O"
      turn_count+=1
    end
  end
  turn_count
end

def current_player(board)
  if turn_count(board)%2==0
    "X"
  else
    "O"
  end
end

# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS=[[0,1,2],
                  [0,3,6],
                  [0,4,8],
                  [1,4,7],
                  [2,5,8],
                  [2,4,6],
                  [3,4,5],
                  [6,7,8]]

def x_won?(board,combo)
  combo.all?{|position| board[position]=="X"}
end

def y_won?(board,combo)
  combo.all?{|position| board[position]=="O"}
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    x_won?(board,combo)||y_won?(board,combo)
  end
end

def full?(board)
  board.all? {|element| element=="X"||element=="O"}
end

def draw?(board)
  full?(board)&&!won?(board)
end

def over?(board)
  draw?(board)|won?(board)
end

def winner(board)
  if won?(board)
    if board[won?(board)[0]]=="X"
      "X"
    else
      "O"
    end
  end
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
  end

end
