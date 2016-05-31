WIN_COMBINATIONS = [
      [0,1,2], #top row win
      [3,4,5], #middle row win
      [6,7,8], #bottom row win
      [0,3,6], #left column win
      [1,4,7], #middle column win
      [2,5,8], #right column win
      [0,4,8], #diagonal \ win
      [2,4,6] #diagonal / win
    ]


def display_board(board)
  puts  " #{board[0]} | #{board[1]} | #{board[2]} "
  puts  "-----------"
  puts  " #{board[3]} | #{board[4]} | #{board[5]} "
  puts  "-----------"
  puts  " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end


def move(board, index, player_character)
  board[index] = player_character
end


def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
  move(board, index, player_character = current_player(board))
  display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
    counter = 0
    board.each do |current_move|
  if current_move == 'X' || current_move == 'O'
    counter += 1
    end
  end
  counter
end


def current_player(board)
  turn_count(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  (WIN_COMBINATIONS).any? do |win_combo|
  if board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X" ||
      board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O"
  return win_combo
  else
  false
end
end
end


def full?(board)
  board.all? do |index|
   index == "X" || index == "O"
end
end

def draw?(board)
if !won?(board) && full?(board)
true
else
false
end
end


def over?(board)
won?(board) || draw?(board)
end



def winner(board)
  if win_combo = won?(board)
  return board[win_combo.first]
end
end



def play(board)
  until over?(board)
    turn(board)
  end
if won?(board)
   puts "Congratulations #{winner(board)}!"
else
   draw?(board)
  puts "Cats Game!"

end
end
