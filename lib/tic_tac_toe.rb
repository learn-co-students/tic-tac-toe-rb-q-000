WIN_COMBINATIONS = [
  [0,1,2], #TOP ROW
  [3,4,5], #MIDDLE ROW
  [6,7,8], #BOTTOM ROW
  [0,3,6], #FIRST COLUMN
  [1,4,7], #MIDDLE COLUMN
  [2,5,8], #LAST COLUM
  [0,4,8], #0 DIAGONAL
  [2,4,6]  #2 DIAGONAL
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, input, char="X")
  board[input.to_i-1] = char
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    return false
  elsif board[position] == "X" || board[position] == "O"
    return true
  end
end

def valid_move?(board, position)
  position = position.to_i
  if position_taken?(board, position - 1) == true && position.between?(1,9)
    return false

  elsif position_taken?(board, position - 1) == false && position.between?(1,9)
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets
  if valid_move?(board, position) == true
    move(board, position, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |boards|
    if (boards == "X" || boards == "O")
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |win_comb|
  position_taken?(board, win_comb[0]) &&
    board[win_comb[0]] == board[win_comb[1]] && board[win_comb[0]] == board[win_comb[2]]
  end
end

def full?(board)
  board.all?{|spot| !(spot.nil? || spot == " ")}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if win = (won?(board))
    board[win[0]]
  end
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
