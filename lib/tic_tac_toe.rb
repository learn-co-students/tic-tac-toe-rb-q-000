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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, position, player)
  board[position] = player
end

def position_taken?(board, position)
  board[position] == "X" || board[position] == "O"
end

def valid_move?(board, position)
  position >= 0 && position <= 8 && board[position] == " " || board[position] == nil
end

def turn_count(board)
  board.count("X") + board.count("O")
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def turn(board)
  puts "Where would you like to move? Choose a position 1-9."
  input = gets.chomp.to_i
  until input >= 1 && input <= 9
    puts "Invalid move. Choose a position 1-9."
    input = gets.chomp.to_i
  end
  board[input - 1] = current_player(board)
  display_board(board)
end

def won?(board)
  win = WIN_COMBINATIONS.find do |win_combination|
    board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X" || board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
  end
end

def full?(board)
  board.all?{|position| position == "X" || position == "O"}
end

def draw?(board)
  if won?(board)
    false 
  elsif full?(board)
    true
  end
end

def over?(board)
  if draw?(board)
    true
  elsif won?(board)
    true
  end
end

def winner(board)
  win = won?(board)
  if over?(board)
    board[win[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end

