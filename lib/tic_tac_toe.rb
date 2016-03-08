board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

def display_board(board)
 
  puts " #{board[0]} " "|" " #{board[1]} " "|" " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " "|" " #{board[4]} " "|" " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " "|" " #{board[7]} " "|" " #{board[8]} "
end

def turn_count(board)
  turns = 0
  board.each do |space|
    if space == "X" || space == "O"
      turns = turns += 1
    end
  end
  turns
end

def move(board, position, current_player = "X")
  board[position.to_i-1] = current_player
end

def position_taken?(board, position)
  if board[position.to_i] == "O" || board[position.to_i] == "X"
    true
  else
    false
  end
end

def valid_move?(board, position)
  position = position.to_i-1 
  position.between?(0,8) && !position_taken?(board, position)
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"    
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if !valid_move?(board, input)
    turn(board)
  end
  move(board, input, current_player(board))
  display_board(board)
end

def won?(board)
  WIN_COMBINATIONS.detect do |position|
    ((board[position[0]] == "X" && board[position[1]] == "X" && board[position[2]] == "X") || (board[position[0]] == "O" && board[position[1]] == "O" && board[position[2]] == "O"))
  
  end 
end

def full?(board)
  board.none?{|position| position == " "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  winner = won?(board)
    if !won?(board)
    nil
    else
    board[winner[0]] 
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
end
end

 