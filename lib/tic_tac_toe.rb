WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, position)
  position = position.to_i
  position.between?(1,9) && !position_taken?(board, position-1)
end

def draw?(board)
  full?(board) && !won?(board)
end

def full?(board)
  !board.detect { |move| move == "nil" || move == " " }
end

def over?(board)
  draw?(board) || won?(board) ? true : false
end

def position_taken?(board, position)
  !(board[position] == " " || board[position] == nil)
end

def won?(board)
  combo = WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
                             board[combo[1]] == board[combo[2]] &&
                                   position_taken?(board, combo[0])
  end
  combo ? combo : false
end

def move(board, position, token = "X")
  board[position-1] = token if valid_move?(board, position)
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn(board)
  puts "Enter position 1-9 to place a move"
  position = gets.chomp
  position = position.to_i
  if valid_move?(board, position)
    move(board, position, current_player(board))
    display_board(board)
  else
    turn(board)
  end
  board
end

def turn_count(board)
 board.count { |move| move == "X" || move == "O"  }
end

def winner(board)
  if combo = won?(board)
    return board[combo.first]
  else
    return nil
  end
end

def play(board)
  while !over?(board) { turn(board) }
    turn(board)
  end
  puts won?(board) ? "Congratulations #{winner(board)}!" : "Cats Game!"
end
