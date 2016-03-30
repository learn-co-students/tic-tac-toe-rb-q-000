WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

# #display_board
def display_board(board = [" "," "," "," "," "," "," "," "," "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# #move
def move(board, input, character="X")
  position = input.to_i - 1
  board[position] = character
  display_board(board)
end

# #position_taken? 
def position_taken?(board, position)
  board[position] == "X" || board[position] == "O"
end 

# #valid_move?
def valid_move?(board, input)
  input.to_i.between?(1,9) && !position_taken?(board, input.to_i - 1)
end

# #turn (using ternary operators)
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  valid_move?(board, input) ? move(board, input, current_player(board)) : turn(board)
end

# #turn_count
def turn_count(board)
  board.select{|square| square != " "}.length
end

# #current_player
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O" 
end

# won?
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] && 
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

# full?
def full?(board)
  board.none?{|spot| spot == " "}
end

# draw?
def draw?(board)
  full?(board) && !won?(board)
end

# over?
def over?(board)
  won?(board) || draw?(board)
end

# winner
def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.last]
  end
end

# play
def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board) 
    puts "Cats Game!" 
  else puts "Congratulations #{winner(board)}!"
  end
end