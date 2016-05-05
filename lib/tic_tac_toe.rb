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

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def move(board, position, player)
  board[position.to_i - 1] = player
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  else
      true
  end
end

def valid_move?(board, position)
  !position_taken?(board, position.to_i - 1) && (position.to_i > 0 && position.to_i < 10)
end


def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if !valid_move?(board, position)
    turn(board)
  end
  move(board, position, current_player(board))
  display_board(board)
end

def turn_count(board)
  board.count{|turn| turn == "X" || turn == "O"}
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.select do |win_combo|
   (board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X") || (board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O")
  end.flatten!
end

def full?(board)
  !(board.include?(" "))
end

def draw?(board)
  if won?(board) == nil && full?(board) == true
    true
  else
    false
  end
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board) == nil
    nil
  else
    winning_board = won?(board)
    winning_move_1 = winning_board[0]
    winning_move_2 = winning_board[1]
    winning_move_3 = winning_board[2]
      if board[winning_move_1] == "X" && board[winning_move_2] == "X" && board[winning_move_3] == "X"
        "X"
      elsif board[winning_move_1] == "O" && board[winning_move_2] == "O" && board[winning_move_3] == "O"
        "O"
      else
        nil
      end
  end
end

