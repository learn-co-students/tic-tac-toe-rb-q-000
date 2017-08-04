# prints a 3x3 Tic Tac Toe board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# codes the players' inputs into an indexed integer
def input_to_index(user_input)
  user_input.to_i - 1
end

# defines a move
def move(array, index, value)
  array[index] = value
end

# determines if a position is taken
def position_taken?(board, index)
  board[index] ==  "X" || board[index] == "O"
end

# determines if a move is valid
def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

# runs the order of turns
def turn(board)
  puts "#{current_player(board)}, please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    "invalid"
    turn(board)
  end
end

# counts the number of turns
def turn_count(board)
  counter = 0
  board.each do |index|
    if index != " "
      counter += 1
    end
  end
  counter
end

# determines whose turn it is
def current_player(board)
  (turn_count(board).even?) ?
  "X" : "O"
end

# a constant defining all possible win scenarios
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left column
  [1,4,7], #middle column
  [2,5,8], #right column
  [0,4,8], #left diagonal
  [2,4,6], #right diagonal
]

# determines if there is a winning scenario
def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      false
    end
  end
  false
end

# determines if the board is full
def full?(board)
  board.all? {|position| position != " "}
end

# determines if the game is a draw
def draw?(board)
  ! won?(board) && full?(board)
end

# determines if the game is over
def over?(board)
  won?(board) || draw?(board) || full?(board)
end

# determines who the winner is
def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]


    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return "X"
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return "O"
    else
      nil
    end
  end
  nil
end

# determines the order of play
def play(board)
  until over?(board)
    turn(board)
  end

  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  elsif draw?(board)
    puts "Cats Game!"
  else
    nil
  end
end
