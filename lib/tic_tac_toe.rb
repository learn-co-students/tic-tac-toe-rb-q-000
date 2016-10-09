#def WIN_COMBINATIONS
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,4,8]
]

#def display_board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#def input_to_index
def input_to_index(user_input)
  user_input.to_i - 1
end

#def move
def move(board, index, player)
  board[index] = player
end

#def position_taken
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

#def valid_move
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

#def turn
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

#def turn_count
def turn_count(board)
  turn_count = 0
  board.each do |x|
    if x != " "
      turn_count += 1
    end
  end
  return turn_count
end

#def current_player
def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

#def won?
def won?(board)
  WIN_COMBINATIONS.find do | win_combination |

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
end

#full?
def full?(board)
  board.all? { | index | index == "X" || index == "O"}
end

# draw? method
def draw?(board)
  if !(won?(board)) && full?(board)
    true
  else
    false
  end
end

#over? method
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

# winner method
def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  elsif draw?(board)
    nil
  end
end

#def play
def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
