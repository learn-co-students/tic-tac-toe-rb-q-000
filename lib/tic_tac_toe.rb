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

def display_board(board)
  dashes = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts dashes
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts dashes
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, spot, xoro = "X")
  spot = (spot.to_i) - 1
  board[spot] = xoro
  return board
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, spot)
  spot = spot.to_i - 1
  if
    position_taken?(board, spot) == false && spot.between?(0,9) == true
    true
  elsif
    position_taken?(board, spot) == true
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  spot = gets.strip
  if valid_move?(board,spot) == true
    move(board, spot,current_player(board))
    display_board(board)
  else turn(board)
  end
end

def turn_count(board)
  # my .each attempt failed, need to read more on the topic
  counter = 0
  spot = 0
  while spot < 9
    if board[spot] == "X" || board [spot] == "O"
      counter += 1
      spot += 1
    else counter = counter
      spot += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if
      (board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]) && (board[combo[0]] == "X" || board[combo[0]] == "O")
      return combo
    end
  end
  return false
end

def full?(board)
  #wasn't getting .any to work, come back to this?
  board.each do |spot|
    if spot == " "
      return false
    end
  end
    return true
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  elsif won?(board) == false && full?(board) == false
    return false
  elsif won?(board) == true
    return false
  end
end

def over?(board)
  if won?(board) == true || full?(board) == true || draw?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  #is this too hard coded?
  if won?(board) == false
    return nil
  else
  winning_player = won?(board)
  return board[winning_player[0]]
  end
end

#should definitely be able to remove the reduncy below
def play(board)
    if won?(board) != false
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board) == true
      puts "Cats Game!"
    end
  while over?(board) != true
    if won?(board) != false
      puts "Congratulations #{winner(board)}!"
    break
    elsif draw?(board) == true
      puts "Cats Game!"
    break
    end
  turn(board)
  end
end
