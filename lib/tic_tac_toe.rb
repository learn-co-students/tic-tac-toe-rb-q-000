# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = board[win_index_1] # load the value of the board at win_index_1
      position_2 = board[win_index_2] # load the value of the board at win_index_2
      position_3 = board[win_index_3] # load the value of the board at win_index_3

      if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return win_combination
      end
  end
  return false
end

def full?(board)
  board.each do |cell|
    if !(cell=="X"||cell=="O")
      return false
    end
  end
  return true
end

def draw?(board)
  if (!won?(board))&&full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if(draw?(board) || won?(board))
    return true
  else
    return false
  end
end

def winner(board)
  x_count = 0
  o_count = 0
  if won?(board)
    board.each do |cell|
      if cell=="X"
        x_count += 1
      end
      if cell=="O"
        o_count += 1
      end
    end
    if x_count > o_count
      return "X"
    else
      return "O"
    end
  end
end

def display_board(board)
  puts (" "+board[0]+" | "+board[1]+" | "+board[2]+" ")
  puts "-----------"
  puts (" "+board[3]+" | "+board[4]+" | "+board[5]+" ")
  puts "-----------"
  puts (" "+board[6]+" | "+board[7]+" | "+board[8]+" ")
end

def move(board, position, char="X")
  board[position.to_i-1]=char
  return board
end

# code your #valid_move? method here
def valid_move?(board, position)
  if position.to_i>=1 && position.to_i<=9 && !position_taken?(board, position.to_i-1)
    return true
  else
    return false
  end
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
  count = 0
  board.each do |cell|
    if cell=="X" || cell=="O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board)%2==0
    return "X"
  else
    return "O"
  end
end

def play(board)
# until the game is over
#   take turns
# end

  until over?(board)
    turn(board)
  end

# if the game was won
#   congratulate the winner
# else if the game was a draw
#   tell the players it has been a draw
# end
  if won?(board)
    puts "Congratulations "+winner(board)+"!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end



