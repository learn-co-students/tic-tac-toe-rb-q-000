def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end


WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [6,4,2],
  [0,4,8]
  ]


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


def turn_count(board) # returns number of turns taken
  counter = 0
  board.each do |spot|
    if spot == "X" || spot == "O"
    counter+= 1
    end
  end
  counter
end


def current_player(board) # returns the current player (but assumes X went first!)
  turn_count(board) % 2 == 0 ? "X" : "O"
end


def won?(board)
  x_o = ["X", "O"]
  x_o.detect do |player|
    WIN_COMBINATIONS.detect do |line|
      if board[line[0]] == player && board[line[1]] == player && board[line[2]] == player
        return line
      end
    end
  end
end


def full?(board) # returns true if board is full, otherwise false
   all_full = board.all? do |contents|
     contents == "X" || contents == "O"
  end
end

def draw?(board) # returns true if the board is full and nobody's won, otherwise false
  if full?(board) && !won?(board)
    true
  end
end

def over?(board) # returns true if the game is won or is a draw, otherwise false
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    board[won?(board).first]
  end
end