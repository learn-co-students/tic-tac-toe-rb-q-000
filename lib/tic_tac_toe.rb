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

board = [" "," "," "," "," "," "," "," "," "]

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

def move(board, index, value)
  if value % 2 == 0
    value = "X"
  elsif value % 2 == 1
    value = "O"
  end
  board[index] = value
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  elsif board[index] == "X" || board[index] == "O"
    true
  end
end

def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0, 8)
      true
    else
      false
    end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |moves|
  if moves == "X"
    counter += 1
  elsif moves == "O"
    counter += 1
  end
  end
counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  elsif turn_count(board) % 2 == 1
    "O"
  end
end

def won?(board)
  game = false
  WIN_COMBINATIONS.each do |win_combo|
    if !game
      if win_combo.all? {|win| board[win] == "X"} || win_combo.all? {|win| board[win] == "O"}
        game = win_combo
      end
    end
  end
  game
end

def full?(board)
  board.all? {|i| i != " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) == true || won?(board) != false || full?(board) == true
end

def winner(board)
  player = won?(board) # returns array such as [0,1,2]
  if player != false
    board[player[0]] # returns value in first position of array
  else
    nil
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cats Game!"
  end
end
