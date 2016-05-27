WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #mid row
  [6,7,8], #low row
  [0,3,6], #left v
  [1,4,7], #mid v
  [2,5,8], #rite v
  [0,4,8], #diag1
  [2,4,6] #diag2
]

# Helper Methods

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

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

def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    else
    end
  end
  return count
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  if board.all?{ |position| position == " " }
    false
  elsif
    WIN_COMBINATIONS.each do |combo|
      plays = [board[combo[0]],board[combo[1]],board[combo[2]]]
      if (plays == ["X","X","X"]) || (plays == ["O","O","O"])
        return combo
      else
        false
      end
    end
  else
    true
  end
end

def full?(board)
  board.none?{ |position| position == " " }
end

def draw?(board)
  full?(board) && !(won?(board))
end

def over?(board)
  if (won?(board)) || (draw?(board)) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  winning_combo = won?(board)
  if winning_combo
    return board[winning_combo[0]]
  else
    nil
  end
end

def play(board)
  while !(over?(board))
    turn(board)
  end

  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
