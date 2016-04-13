WIN_COMBINATIONS = [
  [0,1,2], # Top Row
  [3,4,5], # Middle Row
  [6,7,8], # Bottom Row
  [0,3,6], # First Column
  [1,4,7], # Second Column
  [2,5,8], # Third Column
  [0,4,8], # First Diagonal
  [6,4,2] #Second Diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, character = "X")
  position = position.to_i - 1
  board[position] = character
end

def won?(board)
  if (board.all? { |e| (e == " " || e == "")})
    false
  else
    WIN_COMBINATIONS.detect do |win_combination|
     win_combination.all? { |e| (board[e] == "X") } || win_combination.all? { |e| (board[e] == "O") }
    end
  end
end

def full?(board)
  board.all? do |check|
    check != " "
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end
 
def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  counter = turn_count(board)
  counter % 2 == 0 ? "X" : "O"
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

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end