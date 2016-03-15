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


# Define a method display_board that prints a 3x3 Tic Tac Toe Board
def display_board(board)
  pipe = "|"
  dashes = "-----------"

  print " #{board[0]} "
  print pipe
  print " #{board[1]} "
  print pipe
  print " #{board[2]} "
  puts ""
  puts dashes
  print " #{board[3]} "
  print pipe
  print " #{board[4]} "
  print pipe
  print " #{board[5]} "
  puts ""
  puts dashes
  print " #{board[6]} "
  print pipe
  print " #{board[7]} "
  print pipe
  print " #{board[8]} "
  puts ""

end


# code your move method here!
def move(board, position, character="X")
board[position.to_i-1] = character
end

# code your #position_taken? method here!
def position_taken?(board, position)
  if (board[position]==" " || board[position]=="" || board[position]==nil)
    return false
  elsif (board[position]=="X" || board[position]=="O")
    return true
  end
end


def valid_move?(board, position)

  position=position.to_i
  if (position.between?(1,9) && !position_taken?(board,position))
    return true
  else
    return false
  end
end


def position_taken?(board,position)

  position-=1
  if(board[position]=="X" || board[position]=="O")
    return true
  elsif(board[position]==" ")
    return false
  end
end


def turn(board)
  puts "Please enter 1-9:"
  position=gets.strip
  if (!valid_move?(board, position))
    turn(board)
  end
  move(board,position,current_player(board))
  display_board(board)
end

def turn_count(board)
  i=0
  count=0
  while board.length>i
    if board[i]=="X"
      count+=1
      elsif board[i]=="O"
      count+=1
    end
    i+=1
  end
  return count
end

def current_player(board)
  if turn_count(board).odd?
    return "O"
    else
    return "X"
  end
end


#Define ?won method
def won?(board)
  WIN_COMBINATIONS.detect do |array|
    win_block(board,array)
  end
end

def win_block(board,array)
  (board[array[0]]=="X") && (board[array[1]]=="X") && (board[array[2]]=="X") ||
  (board[array[0]]=="O") && (board[array[1]]=="O") && (board[array[2]]=="O")
end

def full?(board)
  board.all? {|i| i!=" "}
end

def draw?(board)
  if (!won?(board) && full?(board))
    return true
  elsif ((!won?(board) && !full?(board)))
    return false
  elsif won?(board)
    return false
  end
end



def over?(board)
 (won?(board)) || (draw?(board)) || (full?(board))

end

def winner(board)
   if (won?(board))
     return board[won?(board)[0]]
   else
     return nil
   end
end

# Define your play method below
def play(board)
  i=1
  while !over?(board) && i<=9
    turn(board)
    i+=1
  end
  if (won?(board))
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cats Game!"
  end
end
