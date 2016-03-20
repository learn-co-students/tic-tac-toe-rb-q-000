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


def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board) == true
    puts "Cats Game!"
    elsif won?(board)
      puts "Congratulations #{winner(board)}!"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, value = "X")
  position = position.to_i - 1
  board[position] = value
end

def valid_move?(board, position)
position = position.to_i - 1

  if position.between?(0, 8) != true
    false
  elsif position_taken?(board, position) == false
    true
  elsif position_taken?(board, position) == true
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position) == true
    move(board, position, current_player(board))
    display_board(board)
    else
    turn(board)
end
end

def position_taken?(board, position)

  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  elsif board[position] == "X" || board[position] == "O"
    true
end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X"
      return win_combination
      elsif board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
      return win_combination
end
end
  return false
end

def full?(board)
index = [0, 1, 2, 3, 4, 5, 6, 7, 8]
  index.each do |i|
    if position_taken?(board, i) == false
     return false
end
end
  return true
end

def draw?(board)
  if won?(board) == false && full?(board)
    return true
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  end
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
    else
    return "O"
  end
end

def turn_count(board)
  counter = 0
  board_number = 0
board.each do
    if board[board_number] != " "
    counter += 1
    board_number += 1
      else
      board_number += 1
end
end
return counter
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
    if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X"
      return "X"
      elsif board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
      return "O"
    end
  end
    if draw?(board) == true
      return false
    end
end