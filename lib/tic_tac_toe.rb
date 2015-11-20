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
#define display board
def display_board(board = [" "," "," "," "," "," "," "," "," "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your move method here!
def move(board, input ,char="X")
  board[input.to_i-1] = char
  display_board(board)
end

# code your #valid_move? method here
def valid_move?(board,position)
  position=position.to_i-1
  if position.between?(0,8) && !position_taken?(board, position)
    true
  else
    false
  end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, position)
  if board[position] == nil||board[position]==""||board[position]==" "
    false
  else
    true
  end
end

# Turn
def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position,current_player(board))
  else
    turn(board)
  end
end

# Turn Count
def turn_count(board)
  counter = 0
  position = 0
  board.each do |space|
    if position_taken?(board, position)
      counter += 1
    end
    position +=1
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win|
    win1 = win[0]
    win2 = win[1]
    win3 = win[2]

    position1 = board[win1]
    position2 = board[win2]
    position3 = board[win3]

    if (position1=="X" && position2 == "X" && position3 == "X")||(position1=="O" && position2 == "O" && position3 == "O")
      return win
    end
  end
  return false
end

def full?(board)
  board.all? do |space|
    space == "X" || space == "O"
  end
end

def draw?(board)
  if !won?(board)&&full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board)||draw?(board)||full?(board)
    true
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
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


