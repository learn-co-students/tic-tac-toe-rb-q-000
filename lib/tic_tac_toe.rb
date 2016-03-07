WIN_COMBINATIONS = [
  [ 0, 1, 2 ],
  [ 3, 4, 5 ],
  [ 6, 7, 8 ],
  [ 0, 3, 6 ],
  [ 1, 4, 7 ],
  [ 2, 5, 8 ],
  [ 0, 4, 8 ],
  [ 2, 4, 6 ] 
]

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board, location)
  board[location] == "X" || board[location] == "O"
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip  
  player = current_player(board)

  if valid_move?(board, input)
    move(board, input, player)
  else
    turn(board)
  end
  display_board(board)
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def turn_count(board)
  count = 0

  board.each do |available|
    if available == "X" || available == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board).odd?
    return "O"
  else
    return "X"
  end
end

def won?(board)
  for win_combination in WIN_COMBINATIONS
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    if position_taken?(board, win_index_1) && position_taken?(board, win_index_2) && position_taken?(board, win_index_3) && 
      board[win_index_1] == board[win_index_2] && board[win_index_2] == board[win_index_3]
      return win_combination
    end
  end
  return false
end

def full?(board)
  emptySpot = board.detect { |i| i == nil || i == " " }
  gameStatus = won?(board)
 
  if emptySpot
    return false
  end

  if !emptySpot && gameStatus.is_a?(Array)
    return true
  end 

  if !emptySpot && gameStatus == false
    return true
  end 
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || draw?(board) || won?(board)
end

def winner(board)
  winGame = won?(board)

  if winGame 
    checkX = winGame.detect{ |winX| board[winX] == "X"}
    checkO = winGame.detect{ |winO| board[winO] == "O"}

    if checkX
      return "X"
    elsif checkO
      return "O"
    end
  end
  return nil
end