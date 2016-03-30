def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, character="X")
  board[position.to_i - 1] = character
end

def position_taken?(board, position)
 if board[position.to_i] == "X" || board[position.to_i] == "O"
    return true
  else false
 end
end

 def valid_move?(board, position)
    position = position.to_i - 1
    if position.between?(0,8) && !position_taken?(board,position)
      return true
    else false
    end
 end

def turn(board)
    puts "Please enter 1-9:"
   position = gets.strip
   if valid_move?(board, position)
      move(board, position, current_player(board))
      display_board(board)
    else turn(board)
    end
    end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position != " "
    counter += 1
    end
    end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else turn_count(board) % 1 == 1
    return "O"
  end
end

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

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
  return combo if combo.all? do |position| board[position] == "X" end
  return combo if combo.all? do |position| board[position] == "O" end
  end
end

def full?(board)
  board.all?{|character| character == "X" || character == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board) 
    board[won?(board).first]
  else 
    nil
  end
end

def play(board)
  while !over?(board) && !draw?(board) && !won?(board)
    turn(board)
    end
if won?(board)
  puts "Congratulations #{winner(board)}!"
elsif draw?(board)
  puts "Cats Game!"
end
end
