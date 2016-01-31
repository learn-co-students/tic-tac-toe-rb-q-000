WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def display_board(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])
  puts (" #{board[0]} | #{board[1]} | #{board[2]} ")
  puts ("-----------")
  puts (" #{board[3]} | #{board[4]} | #{board[5]} ")
  puts ("-----------")
  puts (" #{board[6]} | #{board[7]} | #{board[8]} ")  
end

def move(board, move_location, character = "X")
  spot = move_location.to_i
  spot = spot - 1
  board[spot] = character
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    return(false)
  else
    return(true)
  end
end

def valid_move?(board, position)
  if position.to_i >=1 && position.to_i <=9 && !position_taken?(board, position.to_i-1)
    true
  end
end

def turn(board)
  puts "Make your move! Choose an empty spot on the board (1-9):"
  move_locale = gets.chomp
  char = current_player(board)

  if valid_move?(board, move_locale)
    move(board, move_locale.to_i, char) #I haven't given a character!?!?!?
  else
    turn(board)
  end
  display_board
end

def turn_count(board)  
  turns_complete = (board.count("X") + board.count("O"))
end

def current_player(board)
  if turn_count(board) == 2 || turn_count(board) == 4 || turn_count(board) == 6 || turn_count(board) == 0
    "X"
  else
    "O"
  end
end

def won?(board)
WIN_COMBINATIONS.each do |win_combination|    
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]
  position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]
  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combination
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return win_combination
  else
    false
end
end
if 
  position_taken?(board, 0) &&
  position_taken?(board, 1) &&
  position_taken?(board, 2) &&
  position_taken?(board, 3) &&
  position_taken?(board, 4) &&
  position_taken?(board, 5) &&
  position_taken?(board, 6) &&
  position_taken?(board, 7) &&
  position_taken?(board, 8) &&
  position_taken?(board, 9) &&
  false
end
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  if !full?(board) || won?(board)
    false
  else
    true
end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
end
end

def winner(board)
if won?(board)
  WIN_COMBINATIONS.each do |win_combination|    
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]
  position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]
  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return "X"
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return "O"
  else
    false
  end
end
else
  nil
end
end

def play(board)
until over?(board) == true
  turn(board)
end
if won?(board)
  puts "Congratulations #{winner(board)}!"
else
  puts "Cats Game!"
end
end





























