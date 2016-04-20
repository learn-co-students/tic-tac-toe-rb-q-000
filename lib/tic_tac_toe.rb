WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6], # Top row
  [1,4,7],  # Middle row
  [2,5,8],
  [0,4,8], # Top row
  [2,4,6]  # Middle row # ETC, an array for each win combination
]

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

def turn_count(board)
  counter=0
  board.each do |x|
   counter+=1 if x=="X" || x=="O"
  end
  counter
end

def current_player(board)
  return "X" if turn_count(board).even?
  return "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    return combination if combination.all?{|spot| board[spot]=="X"}
    return combination if combination.all?{|spot| board[spot]=="O"}
  end
  return false
end

def full?(board)
  return true if board.all?{|x| x=="X" || x=="O"}
  return false
end

def draw?(board)
  return true if full?(board) && !(won?(board))
  return false
end

def over?(board)
  return true if draw?(board) || won?(board) || full?(board)
  return false
end

def winner(board)
  return board[won?(board)[0]] if won?(board)
  return nil
end
# Define your play method below

def play(board)
  until over?(board)
    turn(board)
  end
  puts "Congratulations #{winner(board)}!" if won?(board)
  puts "Cats Game!" if draw?(board)
end