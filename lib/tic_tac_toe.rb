

  # Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #left column
  [1, 4, 7], #middle column
  [2, 5, 8], #right column
  [0, 4, 8], #downward diagonal
  [6, 4, 2]  #upward diagonal
]

board = ["X", "X", "X", " ", " ", " ", " ", " ", " "]

def won?(board)
  array = []
  WIN_COMBINATIONS.each do |win_comb|
  if board[win_comb[0]] == "X" && board[win_comb[1]] == "X" && board[win_comb[2]] == "X"
    array = win_comb
    break
  elsif board[win_comb[0]] == "O" && board[win_comb[1]] == "O" && board[win_comb[2]] == "O"
    array = win_comb
    break
  else
    array = false
  end
end
  array
end

def full?(board)
  board.all?{ |token| token == "X" || token == "O"}
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  end
end

def over?(board)
  if won?(board) || draw?(board) == true
    true
  end
end

def winner(board)
  if win_comb = won?(board)
    board[win_comb.first]
  end
end

def turn_count(board)
  count = 0
  board.each do |b|
    if b != " "
      count += 1
    end
  end
  count
end

def current_player(board)
  player = turn_count(board)
  if player.even?
    player = "X"
  else
    player = "O"
  end
  player
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
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

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
end


end

