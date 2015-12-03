

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n\
 -----------\n\
 #{board[3]} | #{board[4]} | #{board[5]} \n\
 -----------\n\
 #{board[6]} | #{board[7]} | #{board[8]} "
end



WIN_COMBINATIONS = [
  [0,1,2],
  [0,4,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [3,4,5],
  [6,7,8]
  ]


def current_player(board)
  count_o = 0
  count_x = 0
  board.each do |x|
    if (x == "O")
      count_o+=1
    end
    if x == "X"
      count_x +=1
    end
  end
  if (count_x == count_o)
    return "X"
  else
    return "O"
  end
end

def move(board, position, char="X")
  board[position.to_i-1] = char
end

def position_taken?(board, position)
  return board[position.to_i] == "O" || board[position.to_i] == "X"
end

def valid_move?(board,position)
  return !position_taken?(board,position.to_i-1) && position.to_i.between?(1,9)
end



def turn_count(board)
  count = 0
  board.each { |x| count+=1 if (x == "X" || x == "O")}
  return count
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



def won?(board)
  WIN_COMBINATIONS.each do |x|
    if ((board[(x[0])] == "X" && board[(x[1])] == "X" && board[(x[2])] == "X") || (board[(x[0])] == "O" && board[(x[1])] == "O" && board[(x[2])] == "O"))
      return x
      end
    end
  return false
  end

def full?(board)
  board.all? { |x| x == "X" || x == "O" }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    return board[(won?(board)[0])]
  else
    return nil
  end
end

def play(board)
  playing = !over?(board)
  while(playing)
  turn(board)
    won = won?(board)
    playing = !over?(board)
   end
if (won?(board))
  puts "Congratulations #{winner(board)}!"
else
puts "Cats Game!"
end
end

