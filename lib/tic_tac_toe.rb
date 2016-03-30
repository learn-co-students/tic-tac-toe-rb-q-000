WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, input)
  position = input.to_i - 1

  if !position_taken?(board, position) && position.between?(0,9)
    true
  else
    false
  end
end

def position_taken?(board, position)
  if board[position] == "" || board[position] == " " || board[position] == nil
    false
  else
    true
  end
end

def move(board, position, character = "X")
  board[position.to_i - 1] = character
  board
end

def turn(board)
  puts "Please enter 1-9:"
  player_choice = gets.strip

  if valid_move?(board, player_choice)
    move(board, player_choice, current_player(board))
    display_board(board)
  else
    puts "That is not a valid move"
    turn(board)
  end
end

def turn_count(board)
  turn_counter = 0

  board.each do |position|
    turn_counter += 1 if position == "X" || position == "O"
  end

  turn_counter
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |line|
    line.all? { |position| board[position] == "X" } ||
    line.all? { |position| board[position] == "O" }
  end
end

def full?(board)
  board.all? { |position| position == "X" || position == "O" }
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  end
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
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