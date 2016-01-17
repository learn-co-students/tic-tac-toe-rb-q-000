#WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  ]

#display_board method
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#move method
def move(board, position, character = "X" )
  position = position.to_i
  board[position - 1] = character
end

#position_taken? method
def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
     false
  else
     true
  end
end

#valid_move? method
def valid_move?(board, position)
  position = position.to_i
  if position_taken?(board, position - 1) == false && position.between?(1, 9)
    true
  else
    false
  end
end

#turn method
def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position) == true
    move(board, position, current_player(board))
  else
    valid_move?(board, position) == false
    turn(board)
  end
  display_board(board)
end

#turn_count method
def turn_count(board)
  board.count{|space| space == "X" || space == "O"}
end


#current_player method
def current_player(board)
 turn_count(board) % 2 == 0 ? "X" : "O"
end

#won? method
def won?(board)
  WIN_COMBINATIONS.find do |wins|
    board[wins[0]] == board[wins[1]] && board[wins[1]] == board[wins[2]] && position_taken?(board, wins[0])
  end
end

#full? method
def full?(board)
  board.all? do |letter|
    letter == "X" || letter == "O"
  end
end

#draw? method
def draw?(board)
  full?(board) && !won?(board)
end

#over? method
def over?(board)
  won?(board) || draw?(board) || full?(board)
end

#winner method
def winner(board)
  if winner = won?(board)
    board[winner[1]]
  else
    nil
  end
end

#play method
def play(board)
  until over?(board)
  turn(board)
  end
  if
    draw?(board)
      puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end








