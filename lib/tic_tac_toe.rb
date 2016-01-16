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

# Define your play method below
def play(board)
  while !over?(board)
    turn(board)
  end
  if !draw?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end
end

def turn_count(board)
  counter = 0
  board.each do |board_location|
    if board_location == "X" || board_location == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else turn_count(board).odd?
    return "O"
  end
end

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X"
      win_combination
    elsif board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
      win_combination
    else
    end
  end
end

def full?(board)
  board.all? do |board_index|
    if board_index == " "
      false
    else
      true
    end
  end
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board) == nil
    return nil
  elsif board[won?(board)[0]] == "X"
    return "X"
  else board[won?(board)[0]] == "O"
    return "O"
  end
end