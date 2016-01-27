

WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #first column
  [1,4,7], #second column
  [2,5,8], #third column
  [0,4,8], #diagonal from left top down
  [6,4,2] #diagonal from right top down
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts " ----------- "
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts " ----------- "
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, input, current_player = "X")
  board[input.to_i-1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  !position_taken?(board, position.to_i-1) && position.to_i.between?(1,9)
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
  until over?(board) == true
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  elsif winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  end
end

def turn_count(board)
  board.count{|space| space == "O" || space == "X"}
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |wincombo|
    win1 = wincombo[0]
    win2 = wincombo[1]
    win3 = wincombo[2]

    position1 = board[win1]
    position2 = board[win2]
    position3 = board[win3]

    if position1 == "X" && position2 == "X" && position3 == "X"
      return wincombo
    elsif position1 == "O" && position2 == "O" && position3 == "O"
      return wincombo
    end
  end
  false
end

def full?(board)
  board.all? do |index|
    index == "X" || index == "O"
  end
end

def draw?(board)
  if !(won?(board)) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  winning_location = won?(board)
  if winning_location
    board[winning_location[0]]
  else return nil
  end
end
