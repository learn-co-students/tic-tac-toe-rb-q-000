# WIN_COMBINATIONS is a nested array of possible win combinations
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

#display_board prints the current board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#input_to_index converts the user input into an integer
def input_to_index(input)
  index = input.to_i - 1
end

#move sets the token for the player in their chosen position
def move(board, index, current_player)
  board[index] = current_player
end

#position_taken checks to make sure the position is not taken by another player
def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

#valid_move checks to make sure the requested position is a valid move before moving
def valid_move?(board, index)
  if index.between?(0, board.count - 1) && position_taken?(board, index) == false
    true
  else
    false
  end
end

#turn prompts user input for a new turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

#turn_count returns the number of turns that have been played
def turn_count(board)
  turn_counter = 0
  board.each do |turn|
  if turn != " "
      turn_counter += 1
    end
  end
  return turn_counter
end

#current_player determines whose turn it is
def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

#won? detects if winning combination has been played and returns the positions
def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    position_1 == position_2 && position_2 == position_3 &&
    position_taken?(board, win_combination[0])
  end
end

#full? returns true if there are no empty spaces
def full?(board)
  board.all? do |space|
    space != " "
  end
end

#draw? returns true if the game is a draw - the board is full with no winners
def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

#over? returns true if the board is full, or if the game is a draw or has been won
def over?(board)
  draw?(board) || full?(board) || won?(board)
end

#winner? returns the token in the first index of the returned winning position
def winner(board)
  if won?(board)
    board[won?(board).first]
  end
end

#play runs the game
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
