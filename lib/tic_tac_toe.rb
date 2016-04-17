board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

# Helper Method
def display_board(b)
  s  =  " #{b[0]} | #{b[1]} | #{b[2]} \n"
  s +=  "-----------\n"
  s +=  " #{b[3]} | #{b[4]} | #{b[5]} \n"
  s +=  "-----------\n"
  s +=  " #{b[6]} | #{b[7]} | #{b[8]} \n"
  puts s
  s
end

def move(board, position, marker="X")
  pos = position - 1
  if(board[pos] == ' ' && position.between?(1,9))
    board[pos] = marker
  else
    puts "Move not valid, please select and open slot on the board."
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]]

def won?(board)
  WIN_COMBINATIONS.each do |w|
    x = w.all? {|p| board[p] == "X"}
    o = w.all? {|p| board[p] == "O"}
    return w if(x || o)
  end
  return false
end

def full?(board)
  !board.any? {|p| p == ' '}
end

def draw?(board)
  if(full?(board))
    return !won?(board).kind_of?(Array)
  end
  false
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  a = won?(board)
  if a.kind_of?(Array)
    return a.all? {|p| board[p] == "X"} ? "X" : "O"
  end
  nil
end

# code your #valid_move? method here
def valid_move?(board, pos)
  return false if pos == "invalid"
  pos = (pos.to_i-1).to_s
  if position_taken?(board, pos)
    return false
  end
  pos.to_i.between?(0,8)
end

# def position_taken?(board, position)
#   pos = position-1
#   spot = board[pos]
#   spot != " " && spot != nil && spot != ""
# end

def position_taken?(board, location)
  location = location.to_i
  !(board[location].nil? || board[location] == " ")
end

def turn(board)
  puts "Please enter 1-9:"
  pos = ""
  loop do
    pos = gets.chomp
    break if(valid_move?(board, pos))
  end
  move(board, pos.to_i, current_player(board))
  display_board(board)
  pos
end

def turn_count(board)
  count = 0;
  board.each do |p|
    count += 1 if(p != ' ')
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def play(board)
  while !over?(board)
    turn(board)
  end
  who_won = winner(board)
  if(who_won.nil?)
    puts "Cats Game!"
  else
    puts "Congratulations #{who_won}!"
  end
end