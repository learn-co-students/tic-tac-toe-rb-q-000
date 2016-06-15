WIN_COMBINATIONS = [
[0,1,2],
[3,4,5],
[6,7,8],
[2,4,6],
[0,4,8],
[0,3,6],
[1,4,7],
[2,5,8]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  return input.to_i - 1
end

def move(board, index, character)
  board[index] = character
end

def position_taken? (board, index)
  if board[index] == "" or board[index] == " " or board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if !position_taken?(board,index) && index.between?(0,9)
    return true
  else
    return false
  end
end

def turn(board)
#  puts "Welcome to Tic Tac Toe!"
#  display_board(board)
  puts "Please enter 1-9:"
  input = gets.strip()
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turnCounter = 0
  i = 0
  while i < board.length
    if board[i] == "X" || board[i] == "O"
      turnCounter += 1
    end
    i += 1
  end
  turnCounter
end

#current_player(board)
def current_player(board)
  if turn_count(board) % 2 != 0
    return "O"
  else
    return "X"
  end
end

def play(board)
  #9.times do
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do | combo |
    if combo.all?{ | position | board[position] == "X" } || combo.all?{ | position | board[position] == "O" }
       return combo
    end
  end
  return false
end


def full?(board)
#return true for a draw
#if you didn't win and the board has no spaces
  if board.none?{ | position | position == " "}
    return true
  else
    return false
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  elsif won?(board)
    return false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
     nil
  end
end
