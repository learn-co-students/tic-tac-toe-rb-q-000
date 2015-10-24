# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
  ]

def won?(board)
 WIN_COMBINATIONS.detect do |combo|
   combo.all?{|position| board[position] == "X"} || combo.all?{|position| board[position] == "O"}
 end
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  if won?(board) == nil && full?(board) == true
    return true
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
      return true
  else false
   end
end

def winner(board)
  if won?(board)
    first_win_combo = won?(board)[0]
  return board[first_win_combo]
  else
    return nil
  end
end

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

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end

  if draw?(board)
    puts "Cats Game!"
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
    counter += 1
    end
end
  return counter
end

def current_player(board)
  if turn_count(board) == 0
    return "X"
    elsif turn_count(board) % 2 == 1
    return "O"
  elsif turn_count(board) % 2 == 0
    return "X"
  end
end