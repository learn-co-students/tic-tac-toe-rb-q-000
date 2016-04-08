
WIN_COMBINATIONS = [
  [0,1,2], 
  [3,4,5], 
  [6,7,8], 
  [0,4,8], 
  [2,4,6], 
  [0,3,6], 
  [2,5,8], 
  [1,4,7]]

def play(board)
  until over? board
    turn board

    #the following lines were added to try to help tests pass
    if ((won? board) || (over? board))
      break
    end
  end
  the_winner = winner board
  if !(the_winner).nil? 
    puts "Congratulations #{the_winner}!"
  else
    puts "Cats Game!"
  end
  board
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

def position_taken?(board, location)
  #puts "location: #{location}"
  #puts "#{board[location] != " "} && #{ board[location] != ""}"
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def move(board, location, current_player = "X")
  puts "move #{current_player} to #{location.to_i-1}"
  board[location.to_i-1] = current_player
end

def turn_count(board)
  turn_count = 0
  (0..board.size-1).each do |i|
    if position_taken? board, i
      turn_count += 1
    end
  end
  turn_count
end

def current_player(board)
  turn_count(board).odd? ? "O" : "X"
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def won?(board)
  retval = false

  WIN_COMBINATIONS.each do |combo|
    won = combo.all? do |i|
      board[i] == "X"
    end
    if won
      retval = combo
      break
    end

    won = combo.all? do |i|
      board[i] == "O"
    end
    if won
      retval = combo
      break
    end
  end
  retval
end

def full?(board)
  full = board.all? do |square|
      (!square.nil? && square.strip.size > 0) 
  end
end

def draw?(board)
  #true not won and full
  #false not won and not full
  if !(winner board).nil?
    false
  elsif full? board
    true
  else false
  end
end

def over?(board)
  #game is over if we have a winner or board is full
  won?(board) || draw?(board)
  # !(winner board).nil? || (full? board )
end

def winner(board)
  #won returns an array with the winning indices [[0],[1],[4]]
  winner = won? board
  if winner
    board[winner[0]]
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
