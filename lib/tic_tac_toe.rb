def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board,position,token="X")
  board[(position.to_i)-1]=token
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,4,8], #l-top r-bottom
  [2,4,6], #r-top l-bottom
  [0,3,6], #left col
  [1,4,7], #mid col
  [2,5,8] #right col
]

def won?(board)
  WIN_COMBINATIONS.each do |wincombination|
    win_index_1 = wincombination[0]
    win_index_2 = wincombination[1]
    win_index_3 = wincombination[2]

    position_1=board[win_index_1]
    position_2=board[win_index_2]
    position_3=board[win_index_3]

    if (position_1=="X" && position_2=="X" && position_3=="X")||(position_1=="O" && position_2=="O" && position_3=="O")
       return [win_index_1,win_index_2,win_index_3]
    end
  end
  false
end

def full?(board)
  board.each do |cell|
    if (cell==" ")
      return false
    end
  end
  true
end

def over?(board)
  if (draw?(board)||won?(board) )
    true
  else
    false
  end
end

def draw?(board)
  if (full?(board)&&!won?(board))
    true
  else
    false
  end
end

def winner(board)
  if draw?(board)
    nil
  elsif won?(board)
    win=won?(board)
    board[win[0]]
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count=0
  board.each do |x|
    if(x=="X")||(x=="O") 
      count+=1
    end
  end
  count
end

def current_player(board)
  thisTurn=turn_count(board)
  if thisTurn % 2 == 0
    "X"
  else
    "O"
  end
end

def valid_move?(board,position)
  ((0<position.to_i&&position.to_i<10)&&!position_taken?(board,position.to_i-1))
end

def position_taken?(board,position)
  (board[position]=="X"||board[position]=="O")
end

def play(board)
  until (over?(board))
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end