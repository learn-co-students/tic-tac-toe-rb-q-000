
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
  puts"-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char="X")
  position_int = position.to_i - 1
  board[position_int] = char
  return board
end

def position_taken?(board, position)
  position_int = position.to_i
  if board[position_int] == nil || board[position_int] == "" || board[position_int] == " "
    return false
  else
    return true
  end
end

def valid_move?(board, position)
  position_int = position.to_i - 1
  if position_int.between?(0, 8) && !position_taken?(board, position_int)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  while !valid_move?(board, position)
    puts "Please enter 1-9:"
    position = gets.strip
  end
  char = current_player(board)
  board = move(board, position, char)
  display_board(board)
  return board
end

def turn_count(board)
  position = 0
  turns = 0
  while position < board.size
    if position_taken?(board, position)
      turns += 1
    end
    position += 1
  end
  return turns
end

def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  positions_taken = 0
  for i in 0..board.size - 1
    if position_taken?(board, i)
      positions_taken += 1
    end
  end
  if positions_taken == 0
    return false
  end
  x_wins = 0
  y_wins = 0
  final_win_combination = []
  WIN_COMBINATIONS.each do |win_combination|
    if win_combination.all? {|position| board[position] == "X"}
      x_wins += 1
      final_win_combination = win_combination
    elsif win_combination.all? {|position| board[position] == "O"}
      y_wins += 1
      final_win_combination = win_combination
    end
  end
  total_wins = x_wins + y_wins
  if x_wins != y_wins && total_wins > 0
    return final_win_combination
  else
    return false
  end
end

def full?(board)
  [0,1,2,3,4,5,6,7,8].all? {|location| position_taken?(board, location)}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    winning_combination = won?(board)
    board[winning_combination[0]]
  else
    nil
  end
end

def play(board=[" "," "," "," "," "," "," "," "," "])
  display_board(board)
  while !over?(board)
    board = turn(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  else
    puts "Cats Game!"
  end
end
