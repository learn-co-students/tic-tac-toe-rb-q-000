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

display_board(board)

def move(board, position, player = "X")
  position = position.to_i
  board[position.to_i-1] = player
end

position = 0

def position_taken?(board, position)
  position = position.to_i - 1
  if (board[position] == "X" || board[position] == "O")
  return true
  else ((board[position] == " " || board[position] == "") && (board[position] == ![0..8]))
    return false
  end
end

def valid_move?(board, position)
  if position.to_i.between?(1,9) == true && !position_taken?(board, position)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if !position_taken?(board, position) && valid_move?(board, position)
    move(board, position, value = "X")
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
    board.count("X") + board.count("O")
  end

def current_player(board)
  if turn_count(board).even? 
    "X"
  else
    "O"
end
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
  if board.count("X") + board.count("O") < 9
    false
  else
    true
  end
end

def draw?(board)
  if (board.count("X") + board.count("O") == 9) && (won?(board) == false)
    true
  elsif (board.count("X") + board.count("O") < 9) && (won?(board) == true)
    false
  else won?(board) == true
    false  
  end
end

def over?(board)
  if won?(board) == true || draw?(board) == true || full?(board) == true
    true
  else
    false
  end
end

def winner(board)
  result = won?(board)
   if result.is_a?(Array) 
     if board[result[0]] == "X"
        "X"
     else
        "O"
     end
    else
      nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations! #{winner(board)}"
  else
    puts "Cats Game!"
  end
end