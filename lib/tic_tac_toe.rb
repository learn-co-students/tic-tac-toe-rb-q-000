def play(board)
  while !over?(board) do
      turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    end
  if draw?(board)
    puts "Cats Game!"
  end
end


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current = "X")
  board[location.to_i-1] = current
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
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end


    WIN_COMBINATIONS = [
      [0,1,2],
      [3,4,5], # Top row
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6]
      # ETC, an array for each win combination
    ]

def won?(board)
  WIN_COMBINATIONS.each do |wincomb|
    position1 = wincomb[0]
    position2 = wincomb[1]
    position3 = wincomb[2]
    if (board[position1] == "X" && board[position2] == "X" && board[position3] == "X") || (board[position1] == "O" && board[position2] == "O" && board[position3] == "O")
      return wincomb
    end
  end
  return false
end


def full?(board)
  board.all? do |element|
    element == "X" || element == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
  end

def over?(board)
  if draw?(board) || won?(board) || full?(board)
    true
  end
end

def winner(board)
    if won?(board) != false
      return board[won?(board)[0]]
    end
end

def turn_count(board)
counter = 0
  board.each do |xo|
    if xo != " "
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).odd?
    "O"
    else
    "X"
  end
end