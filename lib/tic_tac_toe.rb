board = [" "," "," "," "," "," "," "," "," "]

#display board method
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#move method
def move(array, position, value = "X")
  array[position.to_i - 1] = value
end

#valid move method
def valid_move?(board, position)
  if (position.to_i-1).between?(0,9) && board[position.to_i-1] == " "
    true
  elsif position_taken?(board,position)
    false
  end
end

#position taken method
def position_taken?(board, position)
  if board[position.to_i] == "X" || board[position.to_i] == "O"
    true
  elsif board[position.to_i] == " " || board[position.to_i] == " "
    false
  end
end

#turn method
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip

  if valid_move?(board, input)
    move(board,input, current_player(board))
  else
    puts "That is an invalid move! Try again."
    turn(board)
  end
  display_board(board)
end

#turn count method
def turn_count(board)
  count = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      count += 1
    end
  end
  return count
end

#current player method
def current_player(board)
  if turn_count(board).even?
    return "X"
  elsif turn_count(board).odd?
    return "O"
  end
end

# Define your WIN_COMBINATIONS constant
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

#won method
def won?(board)
  result = false
  WIN_COMBINATIONS.each do |winning_combo|
    if !result
      if winning_combo.all?{|i| board[i]=="X"} || winning_combo.all?{|i| board[i]=="O"}
        result = winning_combo
      end
    end
  end
  result
end

#full method
def full?(board)
  board.all?{|i| (i == "X" || i == "O")}
end

def draw?(board)
  !won?(board) && full?(board)
end

#over method
def over?(board)
  won?(board) || draw?(board) || full?(board)
end

#winner method
def winner(board)
  winning_indices = won?(board)
  if winning_indices
    board[winning_indices[0]]
  else
    nil
  end
end

#play method
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  elsif full?(board)
    puts "This shouldn't happen"
  end
end