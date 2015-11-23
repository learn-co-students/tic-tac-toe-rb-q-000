# Array of winning combinations in tic-tac-toe 
WIN_COMBINATIONS = [
  [0, 1, 2], # First row
  [3, 4, 5], # Second row 
  [6, 7, 8], # Third row
  [0, 3, 6], # First column
  [1, 4, 7], # Second column
  [2, 5, 8], # Third column
  [0, 4, 8], # \ diagonal \
  [2, 4, 6]  # / diagonal / 
  ]

# Method that will print out the current state of the tic-tac-toe board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} |"
  puts "------------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} |"
  puts "------------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} |"
end

# Method sets a position on the board to a token (either "X" or "O")
def move(board, position, player = "X")
  board[position.to_i-1] = player
end

# Method checks to see if the position is currently taken by a token 
def position_taken?(board, position)
  board[position.to_i] != " " && board[position.to_i] != ""
end

# Method checks to see if the user input is a valid position on the board and that the position is empty 
def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

# THis method emulates a turn in tic-tac-toe
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# This method keeps track of how many turns have elapsed 
def turn_count(board)
  count = 0
  board.each do |entry|
    if entry == "X" || entry == "O"
      count+=1
    end
  end
  return count
end

# This method keeps track of whose turn it is ("X" or "O")
def current_player(board)
  turn_count(board)%2 == 0 ? "X" : "O"
end

# This method determines if the current board state has a winning combination 
def won?(board)
  WIN_COMBINATIONS.each do |combination|
    position_1 = board[combination[0]]
    position_2 = board[combination[1]]
    position_3 = board[combination[2]]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return combination
    else
      false
    end
  end
  false
end

# THis method checks if the board is currently full 
def full?(board)
  board.detect{|entry| entry==" "}==nil ? true : false
end

# This method determines whether the board state results in a draw 
def draw?(board)
  won?(board) == false && full?(board) == true ? true : false
end

# This method determines whether the game is over 
def over?(board)
  won?(board) != false || draw?(board) == true || full?(board) == true ? true : false
end

# This method determines who won the game 
def winner(board)
  array = won?(board)
  if array == false
    nil
  else
    board[array[0]] == "X" ? "X" : "O"
  end
end

# This method calls the turn method until the board state is either a win or a draw 
def play(board)
  until over?(board) != false
    turn(board)
  end
  if won?(board)!= false
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cats Game!"
  end
end