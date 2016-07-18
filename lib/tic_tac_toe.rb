WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left column
  [1,4,7], #middle column
  [2,5,8], #right column
  [0,4,8], #top left to bottom right diagonal
  [2,4,6] #top right to bottom left diagonal
]

board = [" ", " ", " ", " "," ", " ", " ", " ", " "]

def display_board(board)
  row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  row2 = " #{board[3]} | #{board[4]} | #{board[5]} "
  row3 = " #{board[6]} | #{board[7]} | #{board[8]} "
  line = "-----------"
  puts row1
  puts line
  puts row2
  puts line
  puts row3
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, player)
board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0, 8) && position_taken?(board, index) == false
    true
  else position_taken?(board, index) == true
    nil
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  valid_move?(board, index)
  #if move is valid
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
      turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |cell|
    if cell == "X"
      counter += 1
    end
    if cell == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
   turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
index_1 = combo[0]
token_1 = board[index_1]
index_2 = combo[1]
token_2 = board[index_2]
index_3 = combo[2]
token_3 = board[index_3]
   if token_1 == "X" && token_2 == "X" && token_3 == "X"
   return combo
   elsif token_1 == "O" && token_2 == "O" && token_3 == "O"
   return combo
   end
  end
  return false
end

def full?(board)
  board.all? do |token|
  token == "X" || token == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if combo = won?(board)
  return board[combo[0]]
  end
end

def play(board)
  until over?(board)
  turn(board)
  end
  if won?(board)
  puts "Congratulations #{winner(board)}!"
elsif
  draw?(board)
  puts "Cats Game!"
  end
end
