#Win Combos
WIN_COMBINATIONS = [
[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[2,4,6]
]

#display board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#move
def move(board, position, char = "X")
  board[position.to_i - 1] = char
end

# position taken?
def position_taken?(board, position)
 (board[position.to_i] ==  " " || board[position.to_i] == "" || board[position.to_i] == nil) ? 
    false : true
end

#valid move?
def valid_move?(board, position)
  if ((position.to_i - 1).between?(0,8) && !position_taken?(board, position.to_i - 1))
    true
  else
    false
  end
end


#turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
if (valid_move?(board, input))
  move(board, input, current_player(board))
  display_board(board)
else
  puts "Invalid move, try again."
  turn(board)
end
end

#turn count
def turn_count(board)
  counter = 0
  board.each do |board|
    if board == "X" || board == "O"
      counter += 1
    end
  end
  counter
end

#current player
def current_player(board)
  turn_count(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end

  
end

#won?
def won?(board)
  WIN_COMBINATIONS.detect do |win|
  if position_taken?(board, win[0]) && position_taken?(board, win[1]) && position_taken?(board, win[2]) && board[win[0]] == board[win[1]] && board[win[0]] == board[win[2]]
    [win[0],win[1], win[2]]
  end
end
end

#full?
def full?(board)
  board.all? do |board|
    board == "X" || board == "O"
  end
end

#draw?
def draw?(board)
  if full?(board) && !won?(board)
    true
  end
end

#over?
def over?(board)
  if won?(board) || draw?(board)
    true
  end
end

#winner
def winner(board)
  if won?(board)
   board[won?(board)[0]] 
  end
end

#play
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

