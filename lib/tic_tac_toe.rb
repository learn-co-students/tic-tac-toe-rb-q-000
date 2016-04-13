WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, pos, char="X")
  board[pos.to_i - 1] = char
end

def position_taken?(board, pos)
  [" ","", nil].none?{|x| board[pos.to_i] == x} 
end

def valid_move?(board, pos)
  pos.to_i.between?(1,9) && !position_taken?(board,pos.to_i-1)
end

def turn(board)
  puts "Enter a move"
  input = gets.strip.to_i
  valid_move?(board,input) ? move(board,input,current_player(board)) : turn(board)
  display_board(board)
end

def turn_count(board)
  board.count("X") + board.count("O")
end

def current_player(board)
  turn_count(board)%2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    return combo if combo.all?{|char| board[char] == "X"} || combo.all?{|char| board[char] == "O"}
  end
  false
end

def full?(board)
  turn_count(board) == 9
end

def draw?(board)
  return true if !won?(board) && full?(board)
  return false if won?(board) || ( !won?(board) && !full?(board) )
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  return nil if won?(board) == false
  board[won?(board)[0]]
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


