WIN_COMBINATIONS = [
  # Horizontal wins:
  [0,1,2], [3,4,5], [6,7,8], 
  # Vertical wins:
  [0, 3, 6], [1, 4, 7], [2, 5, 8],
  # Diagonal wins:
  [0, 4, 8], [2, 4, 6]
]

 board = [" "," "," "," "," "," "," "," "," "]
 
 def display_board(board)
  print " #{board[0]} | #{board[1]} | #{board[2]} "
  print "-----------"
  print " #{board[3]} | #{board[4]} | #{board[5]} "
  print "-----------"
  print " #{board[6]} | #{board[7]} | #{board[8]} "
 end

def move(board, position, player = "X")
  board[position.to_i-1] = player
end

position = position.to_i-1

def position_taken?(board, position)
  if (board[position] == "X" || board[position] == "O")
    return true
  else
    return false
  end
end

def valid_move?(board, position)
  if position.to_i.between?(1,9) == true && !position_taken?(board, position.to_i-1)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end


def turn_count(board)
    board.count{|token| token == "X" || token == "O"}
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = board[win_combination[0]]
    position_2 = board[win_combination[1]]
    position_3 = board[win_combination[2]]

    if (position_1 == "X" && position_2 =="X" && position_3 =="X") || (position_1 == "O" && position_2 =="O" && position_3 =="O")
      return win_combination
    end
  end
  return false
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  win = won?(board)
    return board[win[0]] if win
    nil
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