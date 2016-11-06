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

def input_to_index(str)
  str.to_i - 1
end

def move(board, move, player)
  board[move] = player
end

def position_taken?(board, position)
  board[position] == "X" || board[position] == "O"
end

def valid_move?(board, position)
  if position.between?(0, 8)
    return true unless position_taken?(board, position)
  else
    return false
  end
end

def turn_count(board)
  turn = 0
  board.each do |space|
    turn += 1 if space == "X" || space == "O"
  end

  turn
end

def current_player(board)
  count = turn_count(board)
  return "X" if count.even?
  return "O" if count.odd?
end

def turn(board)
  puts "Please enter 1-9"
  move = gets.chomp
  index = input_to_index(move)

  if valid_move?(board, index)
    # add #displau_board to show updated board state
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  return false if board.all? { |pos| pos == " " }

  WIN_COMBINATIONS.each do |combo|
    if check(board, combo, "X")
      return combo
    elsif check(board, combo, "O")
      return combo
    end
  end

  return false
end

def check(board, array, symbol)
  array.each do |pos|
    return false unless board[pos] == symbol
  end
  true
end

def full?(board)
  if board.none? { |pos| pos == " " }
    return true
  elsif board.include?(" ")
    return false
  end
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  WIN_COMBINATIONS.each do |combo|
    if check(board, combo, "X")
      return "X"
    elsif check(board, combo, "O")
      return "O"
    end
  end

  return nil
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
