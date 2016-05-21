# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# input_to_index
def input_to_index(user_input)
  user_input.to_i - 1
end

# move
def move(board, index, current_player)
  board[index] = current_player
end

# position_taken
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

# valid_move
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# turn_count
def turn_count(board)
  turn_count = 0

  board.each do |counter|
    if counter == "X" || counter == "O"
      turn_count += 1
    end
  end

  turn_count
end

# current_player
def current_player(board)
  turn_count(board).even? ? "X" : turn_count(board).odd? ? "O" : "X"
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [0,3,6],
  [0,4,8],
  [1,4,7],
  [2,5,8],
  [6,4,2],
  [3,4,5],
  [6,7,8]
]

# won
def won?(board)

  WIN_COMBINATIONS.each do |win_combo|
    p1 = board[win_combo[0]]
    p2 = board[win_combo[1]]
    p3 = board[win_combo[2]]

    if (p1 == "X" && p2 == "X" && p3 == "X") || (p1 == "O" && p2 == "O" && p3 == "O")
      return win_combo
    end

  end
    return false
end

# full
def full?(board)
  board.all? { |i| i == "X" || i == "O" }
end

# draw
def draw?(board)
  if (full?(board) == false)
    return false
  else
    if (won?(board) != false)
      return false
    else
      return true
    end
  end
end

# over
def over?(board)
  won?(board) || draw?(board)
end

# winner
def winner(board)
  if (over?(board))
    if (board[won?(board)[0]] == "X")
      return "X"
    else
      return "O"
    end
  else
  end
end

# Define your play method below
def play(board)

  while !over?(board)
    turn(board)
  end
  if won?(board)
    return puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    return puts "Cats Game!"
  end

end
