#helper methods

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Bottom Row
  [0,3,6],  # Left Column
  [1,4,7], # Middle Column
  [2,5,8],  # Right Column
  [0,4,8], # Top Left Diagonal
  [2,4,6]  # Top Right Diagonal
 ]

def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, input, character = "X")
  board[input.to_i-1] = character
end

def position_taken?(board,position)
  !(board[position] == " " || board[position] == "" || board[position] == nil)
end

def valid_move?(board,position)
  if position_taken?(board,position.to_i-1)
    false
  elsif position.to_i-1 > 8
    false
  elsif position.to_i-1 < 0
    false
  else
    true
  end
end

def turn(board)

#  puts "Please enter 1-9:"
#  input = gets.strip
#  if !valid_move?(board, input)
#    turn(board)
#  end
#  move(board, input, current_player(board))
#  display_board(board)

  puts "Please enter 1-9:"
  input = gets.strip
   # if input is valid
    if valid_move?(board,input)
   # make the move for input
      move(board,input,character = current_player(board))
   # else
    else
   # ask for input again until you get a valid input
      turn(board)
   # end
    end
  display_board(board)

end

def turn_count(board)
  counter = 0
  board.each do |slot|
    if slot == "X"
      counter += 1
    elsif slot == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
#  if turn_count(board) % 2 == 0
#    "X"
#  else
#    "O"
#  end
end

# won method

def won?(board)
#  WIN_COMBINATIONS.detect do |combo|
#    board[combo[0]] == board[combo[1]] &&
#    board[combo[1]] == board[combo[2]] &&
#    position_taken?(board, combo[0])
#  end
  WIN_COMBINATIONS.detect do |win_combination|
    board[win_combination[0]] == board[win_combination[1]] &&
    board[win_combination[1]] == board[win_combination[2]] &&
    position_taken?(board,win_combination[0])

  end
end

# full method

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end

end

# draw method

def draw?(board)
  if full?(board) == true && !won?(board) == true
    true
  else
    false
  end
end

# over method

def over?(board)
  won?(board) || draw?(board)
#  if won?(board) != nil || draw?(board) == true || full?(board) == true
#    true
#  else
#    false
#  end
end

# winner method

def winner(board)

  if winning_list = won?(board)
    board[winning_list.first]
  else
  end
end

#play method

def play(board)

#  while !over?(board)
#    turn(board)
#  end
#  if won?(board)
#    puts "Congratulations #{winner(board)}!"
#  elsif draw?(board)
#    puts "Cats Game!"
#  end
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end


end