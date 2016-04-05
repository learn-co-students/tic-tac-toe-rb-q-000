WIN_COMBINATIONS = [
  [0,1,2], # top row
  [0,3,6], # first column
  [0,4,8], # down diagonal
  [1,4,7], # middle column
  [2,4,6], # up diagonal
  [2,5,8], # last column
  [3,4,5], # middle row
  [6,7,8]  # bottom row
]

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
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "#{current_player(board)}'s turn. Please enter 1-9:"
  input = gets.strip
  puts "DEBUG: #{input}"
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  turn = 0
  board.each do |loc|
    if loc == "X" || loc == "O"
      turn += 1
    end
  end
  turn 
end

def current_player(board)
  turn = turn_count(board)
  if turn % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    x_win = position_1 == "X" && position_2 == "X" && position_3 =="X"
    o_win = position_1 == "O" && position_2 == "O" && position_3 =="O"

    x_win || o_win
  end
end

def full?(board)
  board.none? do |location|
    location == " " || location == "" || location == nil
  end
end

def draw?(board)
  won?(board) == nil && full?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if won?(board)
    if board[won?(board)[0]] == "X"
      "X"
    else
      "O"
    end
  else
    nil
  end
end

def play(board)
  until over?(board)
    # take turns
    turn(board)
    if draw?(board)
      break
    end
  end

  if won?(board)
    # congratulate the winner
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    # tell the players it has been a draw
    puts "Cats Game!"
  end
end