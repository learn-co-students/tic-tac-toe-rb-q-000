WIN_COMBINATIONS = [
  [0,1,2], #horizontal top row
  [3,4,5], #horizontal middle row
  [6,7,8], #horizontal bottom row
  [0,3,6], #vertical first column
  [1,4,7], #vertical second column
  [2,5,8], #vertical third column
  [0,4,8], #top left to bottom right diagnoal
  [2,4,6] #top right to bottom left diagnoal
]

def display_board(board = " ")
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input)
  index = user_input.to_i - 1
end

def turn(board)
  puts "Please enter 1-9:"
  value = gets.strip
  index = input_to_index(value)
  if valid_move?(board, index)
    value = current_player(board)
    move(board, index, value)
    display_board(board)
  else
    puts "Please re-enter a valid input"
    turn(board)
  end
end

def position_taken?(board, index)
  if board[index] == "O"
    return true
  elsif board[index] == "X"
    return true
  elsif board[index] != "X"
    return false
  elsif board[index] != "O"
    return false
  end
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0,8)
    return true
  else
    return false
  end
end

def move(board, index, value)
    board[index] = value

end

def turn_count(board)
  counter = 0
    board.each do |position|
      if position == "X"
        counter += 1
      elsif position == "O"
        counter += 1
      else
        counter = counter
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = board[win_index_1] # load the value of the board at win_index_1
      position_2 = board[win_index_2] # load the value of the board at win_index_2
      position_3 = board[win_index_3] # load the value of the board at win_index_3
      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination # return the win_combination indexes that won.
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      end
  end
  board.each do |index|
    if index == " "
      return false
    else
      return false
    end
  end
end

def full?(board)
    if board.include? " "
      return false
    else
      return true
  end
end

def draw?(board)
  won = won?(board)
  if full?(board) && !won
    return true
  else
    return false
  end
end

def over?(board)
    if draw?(board) || won?(board) || full?(board)
      return true
    else
      return false
  end
end

def winner(board)
if winner = won?(board)
  if board[winner[0]] == "X"
    return "X"
  elsif board[winner[0]] == "O"
    return "O"
  end
else
  return nil
end
end

def play(board)
until over?(board) == true
  turn(board)

end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
