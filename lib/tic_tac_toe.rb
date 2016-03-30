WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8],# L to R Diagonal
  [2,4,6] # R to L Diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, player = 'X')
  location = location.to_i
  board[location - 1] = player
  board
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, position)
  position = position.to_i
  if position.between?(1,9) && position_taken?(board, position - 1) == false
    return true
  else
    return false
  end
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
  moves = 0
  board.each do |pos|
    if pos == 'X' || pos == 'O'
      moves += 1
    end
  end
  return moves
end

def current_player(board)
  turn_count(board).even? ? 'X' : 'O' 
end

def won?(board)
  WIN_COMBINATIONS.detect do |combination|
   x_win = combination.all? do |pos|
             board[pos] == 'X' 
           end

   o_win = combination.all? do |pos|
             board[pos] == 'O' 
           end
   x_win || o_win
  end
end

def full?(board)
  board.all? do |pos|
    position_taken?(board, board.index(pos))
  end
end

def draw?(board)
  if full?(board) == true && won?(board) == nil
    return true
  else 
    false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  end
end

def winner(board)
  if won?(board) != nil
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