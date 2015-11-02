WIN_COMBINATIONS = [
   [0,1,2] ,
   [3,4,5] ,
   [6,7,8] ,
   [0,3,6] ,
   [1,4,7] ,
   [2,5,8] ,
   [0,4,8] ,
   [6,4,2]
  ]

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end


def display_board(board)
  print " #{board[0]} | #{board[1]} | #{board[2] } "
  print "------------------------------------------"
  print " #{board[3]} | #{board[4]} | #{board[5] } "
  print "------------------------------------------"
  print " #{board[6]} | #{board[7]} | #{board[8] } "
end

def valid_move?(board, input)
  if input.to_i.between?(1,9)
    if !position_taken?(board, input.to_i-1)
      true
   end
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |win|
    board[win[0]] == board[win[1]] &&
    board[win[1]] == board[win[2]] &&
    position_taken?(board, win[0])
   end
end

def full?(board)
  board.all?{|i| i == "X" || i == "O"}
end

def draw?(board)
  !won?(board) ||  full?(board) &&
  !won?(board) || !full?(board) &&
  won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
   valid_move?(board,input)
  if valid_move?(board,input) == true
    move(board,input)
    display_board(board)
  else
    turn(board)
  end
end

def position_taken?(board,input)
  if board[input] == " " || board[input] == "" || board[input] == nil
    return false
  else
    return true
end
end

def current_player(board)
   turn_count(board) % 2 == 0 ? "X" : "O"
 end

def turn_count(board)
    board.count{|play| play == "X" || play == "O"}

   turn = 0
   board.each do |play|
    if play == "X" || play == "O"
      turn += 1
     end
   end
  return turn

 end


def move(board,input, char = "X")
  board[input.to_i-1] = char
  return board
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
 end

def play(board)
  while !over?(board)
    turn(board)
  end
end













