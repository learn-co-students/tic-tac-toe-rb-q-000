
WIN_COMBINATIONS = [
  [0,1,2], 
  [3,4,5], 
  [6,7,8], 
  [0,3,6], 
  [1,4,7], 
  [2,5,8], 
  [0,4,8], 
  [6,4,2]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, current_player = "X")
  board[position.to_i-1] = current_player
end

def position_taken?(board, position)
  board[position] != " " && board[position] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    # Get the current player's token, X or O
    current_token = current_player(board)
    # pass the current player's token to the board
    move(board, position, current_token)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each {|character| 
    if (character == "X") || (character == "O") 
      count +=1 
    end
  }
  count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |win|
    win.all? {|e| board[e] == 'X'} || win.all? {|e| board[e] == 'O'}
  end
end

def full?(board)
  if board.none?{|position|position == " "}
    return true
  else
    return false
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) 
end

def winner(board)
    WIN_COMBINATIONS.each do |combo|
    return "X" if combo.all? {|position| board[position] == 'X'}
    return "O" if combo.all? {|position| board[position] == 'O'}
  end
  return nil
end

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