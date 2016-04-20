WIN_COMBINATIONS =[ [0,1,2], [3,4,5], [6,7,8], [0,4,8], [1,4,7], [0,3,6], [2,5,8], [6,4,2] ]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, value = "X")
  board[position.to_i - 1] = value


  return board
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position) == true
   move(board, position, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
counter = 0
  board.each do |index|
if index == "X" || index == "O"
  counter += 1
end

  end
counter
end


def current_player(board)
  if turn_count(board) %2 == 0
    "X"
    else "O"
  end

end

def won?(board)
 WIN_COMBINATIONS.each do |combos|
   if board[combos[0]] == " " && board[combos[1]] == " " && board[combos[2]] == " "
  false
     elsif board[combos[0]] == board[combos[1]] && board[combos[0]] == board[combos[2]]
       return combos
     end
   end
  false
end

def full?(board)
  board.each do |board_position|
    if board_position == " "
      return false
  end
  end
end


def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
 end
end

 def over?(board)
  if won?(board) || full?(board)
  return true
  else
  return false

  end
 end

def valid_move?(board, position)
  position = position.to_i - 1
  if position_taken?(board, position) == false && position.between?(0, 10)
    return true
  elsif board[position] == "X" || board[position] == "O"
    return false
  end
end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

  def play(board)
  while !over?(board)
    turn(board)
  end
    current_player(board)
  if won?(board)
    puts "Player somebody won"
  elsif draw?(board)
    puts "This game is a draw"
  end
  end




def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end



board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
