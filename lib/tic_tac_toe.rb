WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # 1st column
  [1,4,7], # 2nd column
  [2,5,8], # 3rd column
  [0,4,8], # 1st diagnal
  [2,4,6]  # 2nd diagnal
]

# displays the current tic tac toe board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


# takes the position and converts it to the appropriate array indexes
def input_to_index(position)
  index = position.to_i - 1
  #index = position - 1
  return index
end


# Moves an 'X' or an 'O' into the appropriate index on the board
def move(board, index, player_token)
    board[index] = player_token
    return board
end


# Returns true if the position on the board is full
def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    return true
  else
    false
  end
end


# Returns true if the position on the board is avialable to move into
def valid_move?(board, index)
  if position_taken?(board, index) != true && index.between?(0, 8)
    return true
  else
    false
  end
end


# Accepts user input to take their turn.  Default is 'X' bc 'X' starts the game
def turn(board, player="X")
  puts "Enter a position on the TTT Board. Must be an integer 1 thru 9: "
  input = gets.chomp
  input = input_to_index(input)
  if valid_move?(board, input)
    board[input] = player
  else
    turn(board)
  end
end


# we'll use this to determine whose move is next.
=begin
def turn_count(board)
  count = 1
  board.each do |value|
    if value == "X" or value == "Y"
      count += 1
    end
  end
  return count
end
=end


def turn_count(board)
  count = 0
  index = 0
  while index < 10
    if position_taken?(board, index) == true
    count += 1
    end
    index += 1
  end
  return count
end


# determines whose turn it is
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end


# returns true if there is a winning combination on the board
def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end
  end
  return false
end


# Checks to see if the game is a draw
def full?(board)
  board.all? do |position|
    position != " "
  end
end


def draw?(board)
  !won?(board) && full?(board)
end


def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end


def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X")
      return "X"
    elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return "O"
    end
  end
  return nil
end


=begin
until the game is over
  take turns
end

if the game was won
  congratulate the winner
else if the game was a draw
  tell the players it has been a draw
end
=end
def play(board)
  until over?(board) == true
    player = current_player(board)
    turn(board, player)
    display_board(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
