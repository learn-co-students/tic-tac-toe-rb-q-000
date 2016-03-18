WIN_COMBINATIONS =[
  [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]
  ]

def play(board)
   while !over?(board)
     turn(board)
   end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
    else draw?(board)
    puts "Cats Game!"
  end
end

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
  if !valid_move?(board, input)
    turn(board)
  end
  move(board, input, current_player(board))
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |board|
    if board == "X" || board == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  player_one = "X"
  player_two = "O"

  if turn_count(board) % 2 == 0
    player_one
  else
    player_two
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |winner|
    board[winner[0]] == board[winner[1]] &&
    board[winner[1]] == board[winner[2]] &&
    position_taken?(board, winner[0])
  end
end

def draw?(board)
  !won?(board) && board.all? { |player| player == "X" || player == "O" }
end

def full?(board)
  board.all? {|player| player == "X" || player == "O"}
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if winner = won?(board)
    board[winner.first]
  end
end

