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

  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "

end


def move(board, position, value = current_player(board))
  board[position.to_i - 1] = value
end


def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end


def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input)
  else
    turn(board)
  end
  display_board(board)
end


def turn_count(board)
  counter = 0
  board.each do |place|
    if place != " "
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
  WIN_COMBINATIONS.detect do |win_combination|
  board[win_combination[0]] == "X"  && board[win_combination[1]] == "X" && board[win_combination[2]] == "X" || board[win_combination[0]] == "O"  && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
  end
end


def full?(board)
  board.all? do |index|
    index != " "
  end
end


def draw?(board)
  !(won?(board)) && full?(board)
end


def over?(board)
  won?(board) || full?(board) || draw?(board)
end


def winner(board)
 if won?(board)
  win_combo = won?(board)
 else
 return nil
 end 

 if board[win_combo[0]] == "X"
  "X"
  
 elsif board[win_combo[0]] == "O"
  "O"
 end
end

def play(board)
  until over?(board)
  current_player(board)
  turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"

  elsif draw?(board)
    puts "Cats Game!"
  
  end
end




