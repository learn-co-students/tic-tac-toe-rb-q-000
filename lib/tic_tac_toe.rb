WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, character = "X")
  board[location.to_i-1] = character
end

def position_taken?(board, position)
 board[position] != "" || board[position] == " "
 if board[position] == "" || board[position] == " "
  false
   elsif board[position] == "X" || board[position] == "O"
   true
   elsif board[position] == nil
   false
 end
end

def valid_move?(board, position)
  position = position.to_i
  position -= 1
  (position.between?(0,8)) && !(position_taken?(board, position))
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
  counter = 0
  board.each do |pos|
    if pos == "X" || pos == "O"
      counter += 1
    end
    end
  return counter
  end

def current_player(board)
  if turn_count(board) % 2 == 0
  return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |wc|
    p1 = board[wc[0]]
    p2 = board[wc[1]]
    p3 = board[wc[2]]

    if (p1 == "X" && p2 == "X" && p3 == "X") || (p1 == "O" && p2 == "O" && p3 == "O")
      return wc
    end
  end
  return false
end

def full?(board)
  board.none?{|position| position == " "}
end

def draw?(board)
  !(won?(board)) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
won = won?(board)
  if won.class == Array
  return board[won[0]]
end
end

def play(board)
until over?(board)
  turn(board)
end
if won?(board)
  puts "Congratulations #{winner(board)}!"
end
if draw?(board)
 puts "Cats Game!"
end
end