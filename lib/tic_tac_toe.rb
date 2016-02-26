WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Diagonal 1
  [2,4,6], # Diagonal 2
]

# Helper Methods
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
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board, current_player = "X")
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  pos_taken = board.reject{ |i| i == " "}
  return pos_taken.count
end

def current_player(board)  #actually returns what the next move/player should be
  if (turn_count(board) % 2) == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    index_1 = combination[0]
    index_2 = combination[1]
    index_3 = combination[2]

    position_1 = board[index_1]
    position_2 = board[index_2]
    position_3 = board[index_3]
    #puts "Board: #{board[index_1]}, #{board[index_2]}, #{board[index_3]}"
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
       (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return combination
    end
  end
  return false
end

def full?(board)
  !board.any?{ |i| i == " " }
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  won_location = won?(board)
  puts "Won: #{won_location}"
  if won_location == false
    return nil
  else
    return board[won_location[0]]
  end
end

def play(board)
  until over?(board) do
    next_turn = current_player(board)
    if next_turn == "X"
      turn(board)
    else
      turn(board, next_turn)
    end
  end
  who_won = winner(board)
  if who_won == "X"
    puts "Congratulations X!"
  elsif who_won == "O"
    puts "Congratulations O!"
  else
    puts "Cats Game!"
  end 
end