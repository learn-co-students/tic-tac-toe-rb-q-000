# Helper Methods
def display_board(brd)
  line1 = " #{brd[0]} | #{brd[1]} | #{brd[2] } "
  divide = '-' * 11
  line2 = " #{brd[3]} | #{brd[4]} | #{brd[5] } "
  line3 = " #{brd[6]} | #{brd[7]} | #{brd[8] } "
  puts line1, divide, line2, divide, line3
end


def turn_count(board)
  count = 0
  board.each do |position|
    if position != "" && position != " " && position != nil
      count +=1
    end
  end
  return count
end


def current_player(board)
  counted = turn_count(board)
  (counted == 0 ||counted % 2 == 0)? "X" : "O"
end


def move(board, location, current_player = current_player(board))
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
    move(board, input)
  else
    turn(board)
  end
  display_board(board)
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,4,8],  # Top left diagonal
  [6,4,2],  # Top right diagonal
  [0,3,6],  # first column
  [1,4,7],  # middle column
  [2,5,8]  # last column
  ]


def won?(board)
  WIN_COMBINATIONS.detect do |line|
    line.all?{|i| board[i] == "X" } || line.all?{|i| board[i] == "O"}
  end
end

def full?(board)
  board.all?{|position| position == "X" || position == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
  end

def winner(board)
  if won?(board)
  line = won?(board)
  board[line[0]]
  end
end


# Define your play method below

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end


