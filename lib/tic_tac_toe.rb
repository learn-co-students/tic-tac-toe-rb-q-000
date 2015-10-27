WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, pos, char='X')
  board[pos.to_i-1] = char
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, pos)
  !position_taken?(board, pos.to_i - 1) && (1..9).include?(pos.to_i)
end

def turn(board)
  puts "Please enter 1-9:"
  pos = gets.strip

  if valid_move?(board, pos)
    move(board, pos, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.select {|c| c != " "}.count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  winning_combo = nil

  WIN_COMBINATIONS.each do |combo|
    winning_combo = combo if combo.all? {|c| board[c] == "X"} || combo.all? {|c| board[c] == "O"}
  end

  winning_combo
end

def full?(board)
  board.all? {|p| p != " " && !!p}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end