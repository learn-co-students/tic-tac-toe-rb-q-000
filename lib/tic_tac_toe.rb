# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def xs_n_os(board)
  xs = []
  os = []
  board.each_with_index do |item, idx|
    if item == "X" then xs << idx end
    if item == "O" then os << idx end
  end
  return [xs, os]
end

def won?(board)
  xs_n_os = xs_n_os(board)
  WIN_COMBINATIONS.each do |com|
    if com.all?{|pos| xs_n_os[0].include?(pos)} then return com end
    if com.all?{|pos| xs_n_os[1].include?(pos)} then return com end
  end
  return false
end

def full?(board)
  return board.all?{|item| ["X", "O"].include?(item)}
end

def draw?(board)
  return (!won?(board) && full?(board))
end

def over?(board)
  return (draw?(board) || won?(board))
end

def winner(board)
  win = won?(board)
  if win == false then return nil end
  return board[win[0]]
end

def move(board, pos, ox)
  board[pos.to_i - 1] = ox
end

def turn(board)
  puts "Please enter 1-9:"
  pos = gets.strip
  if(valid_move?(board, pos))
    move(board, pos, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def display_board (arr)
  puts " #{arr[0]} | #{arr[1]} | #{arr[2]} "
  puts "-----------"
  puts " #{arr[3]} | #{arr[4]} | #{arr[5]} "
  puts "-----------"
  puts " #{arr[6]} | #{arr[7]} | #{arr[8]} "
end

def valid_move?(board, pos)
  posi = pos.to_i
  return 1 <= posi && 9 >= posi && !position_taken?(board, posi - 1)
end

def turn_count(board)
  count = 0
  board.each do |spot|
    if ![""," ", nil].include?(spot)
      count += 1
    end
  end
  return count
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end