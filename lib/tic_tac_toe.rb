# Define your WIN_COMBINATIONS constant
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

def move(board,position,value="X")
  board[position.to_i - 1] = value
end

def position_taken?(board,position)
  !(board[position] == " " || board[position] == "" || board[position] == nil)
end

def valid_move?(board,position)
  position = position.to_i # position comes from a user input. So it is a string. We need to convert it to an int
  position.between?(1,9) && !position_taken?(board,position - 1)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board,position)
    current_player = current_player(board)
    move(board,position,current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |value|
    if (value == "X" || value == "O")
      counter += 1
    end
  end
  counter
end

def current_player(board)
  current_turn = turn_count(board)
  current_turn.even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    value_1 = board[win_index_1] # load the value of the board at win_index_1
    value_2 = board[win_index_2] # load the value of the board at win_index_2
    value_3 = board[win_index_3] # load the value of the board at win_index_3
    value_is_identic = (value_1 == value_2) && (value_2 == value_3 )
    all_positions_taken = position_taken?(board, win_index_1)  && position_taken?(board, win_index_2) && position_taken?(board, win_index_3)

    return win_combination if (all_positions_taken && value_is_identic)
  end
  return false
end

def full?(board)
  board.all? do |value| value == "X" or value == "O" end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  win_combination = won?(board)
  board[win_combination[0]] if win_combination
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
