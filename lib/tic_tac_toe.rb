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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, player="X")
  board[location.to_i - 1] = player
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  else
    true
  end
end

def valid_move?(board, position)
  if position_taken?(board, position.to_i - 1) == true
    false
  elsif position.to_i - 1 > 9 || position.to_i - 1 < 0
    false
  else
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position) == true
    move(board, position, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
plays=0
board.each do |turn|
  if turn == "X" || turn == "O"
  plays += 1
end
end
return plays
end


def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.each do |win_mix|
    win_index_1 = win_mix[0]
    win_index_2 = win_mix[1]
    win_index_3 = win_mix[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_mix
    end
    end
else
  return false
end

def full?(board)
  if board.include? (" ")
    return false
end
else
  return true
end


def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end


def play(board)
  until over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

















