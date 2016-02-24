WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8],
  [0,3,6], [1,4,7,], [2,5,8],
  [0,4,8], [2,4,6]
  ]
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
def turn_count(board)
  i = 0
  board.each do |cell|
    i += 1 if (cell == "X") || (cell == "O")
  end
  i
end

def current_player(board)
  turn_count(board).odd? ? "O" : "X"
end

def move(board, location, current_player)
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
  elsif !over?(board)
    turn(board)
  end
  display_board(board)
end

def play(board)
  turn(board) until over?(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |comb|
    if position_taken?(board,comb[0])
      $win = board[comb[0]]
      comb.all? {|ind| board[ind] == $win}
    end
  end
end

def full?(board)
  ind = [0,1,2,3,4,5,6,7,8]
  ind.all? {|i| position_taken?(board, i)}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    $win == "X" ? "X" : "O"
  end
end