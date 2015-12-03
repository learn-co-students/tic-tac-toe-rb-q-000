# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], # top row
  [3, 4, 5], # middle row
  [6, 7, 8], # bottom row
  
  [0, 3, 6], # left column
  [1, 4, 7], # middle column
  [2, 5, 8], # right column

  [0, 4, 8], # left diagonal
  [6, 4, 2]  # right diagonal
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
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
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
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  win_combination ||= nil
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
    end
  end
  return win_combination
end

def full?(board)
  board.none? do |position|
    position == "" || position == " "
  end
end

def draw?(board)
  if !full?(board)
    return false
  elsif won?(board)
    return false
  else
    return true
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  end
end

def winner(board)
  winning = won?(board)
  winning ? board[winning[0]] : nil
end

# End of Helper Methods

def play(board)
  until over?(board)
    turn(board)
    turn_count(board)
  end
  if over?(board)
    if won?(board)
      return puts "Congratulations #{winner(board)}!"
    else
      return puts "Cats Game!"
    end
  end
end




