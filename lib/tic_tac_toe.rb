# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,4,8]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position = position.to_i - 1
  if position.between?(0,9)
    if position_taken?(board,position)
      return false
    else
      return true
    end
  else
      return false
  end
end

def move(board, position, token = "X")
  board[position-1] = token
  return board
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip.to_i
  player = current_player(board)

  if valid_move?(board, position.to_s)
    move(board, position, player)
    display_board(board)
  else
    puts "Invalid move, please enter another 1-9"
    turn(board)
  end
end

def turn_count(board)
  count = 0;
  board.each{|item| item == "X" || item == "O" ? count += 1 : count += 0}
  return count
end

def current_player(board)
  count = turn_count(board)
  return count % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if  board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
      return combo
    elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
     return combo
    else
    end
  end
  return false
end

def full?(board)
  board.all? {|position| position == "X" || position == "O"}
end

def draw?(board)
  !won?(board) && full?(board) ? true : false
end

def over?(board)
  if won?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  combo = won?(board)
  if(!won?(board))
    return nil
  elsif  board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
    return "X"
  elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
    return "O"
  else
    return nil
  end
end

def play(board)
  until(over?(board))
    turn(board)
  end

  if(won?(board))
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end