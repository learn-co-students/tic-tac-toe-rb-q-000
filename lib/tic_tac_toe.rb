board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]} "
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def input_to_index(input)
  input.to_i - 1
end

def valid_move?(board, index)
  if position_taken?(board, index)
    false
  elsif index.between?(0,8)
    true
  else
    nil
  end
end

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

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |combo|
    if ((board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X") ||
      (board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"))
      ""
    else
      false
    end
  end
end


def move(board, index, character)
  board[index] = character
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip.to_i
  index = input_to_index(position)
  character = current_player(board)
  if valid_move?(board, index)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
  
end

def full?(board)
  board.all?{|marker| marker == "X" || marker == "O"}
end

def draw?(board)
  false if won?(board)
  true if full?(board) && !won?(board)

end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if combo_or_nil = won?(board)
    board[combo_or_nil[0]]
  end
end

def turn_count(board)
  turn_count = 0
  for board_space in board
    if board_space == "X" || board_space == "O"
      turn_count += 1
    else
      ""
    end
  end
  turn_count
end

def current_player(board)
  return "X" if turn_count(board) % 2 == 0
  return "O" if turn_count(board) % 2 == 1
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cats Game!"
  end

end








