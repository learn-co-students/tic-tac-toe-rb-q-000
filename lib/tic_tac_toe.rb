WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, marker = "X")
  board[position.to_i - 1] = marker
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  !position_taken?(board, position.to_i - 1) && position.to_i.between?(1,9)
  end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position, current_player(board))
    display_board(board)
  else
    turn(board)
end
end

def turn_count(board)
  board.count("X") + board.count("O")
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
 board[combo[0]] == board[combo[1]] &&
 board[combo[1]] == board[combo[2]] &&
 position_taken?(board, combo[0])
  end
end

def full?(board)
  board.none?  {|full_board| full_board == " "} && won?(board) != true
end

def draw?(board)
  if won?(board)
    return false
  else full?(board)
end
end

def over?(board)
  full?(board)
end

def winner(board)
  if won?(board)
  board[won?(board)[0]]
  else nil
  end
end

def play(board)
  turn(board) until won?(board) || over?(board) || draw?(board) || turn_count(board) == 9
if won?(board)
  puts "Congratulations #{winner(board)}!"
else draw?(board)
puts "Cats Game!"
end
end
