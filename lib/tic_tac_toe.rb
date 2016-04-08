WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
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

def valid_move?(board, position)
  if !(position.to_i.between?(1, 9))
    return false
  elsif position_taken?(board, position)
    return false
  else
    return true
  end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, location)
  !(board[location] == " " || board[location] == "")
end

def move(board, position, player = "X")
  position = position.to_i - 1
  board[position] = player
end

def turn(board)
  puts "Please enter 1-9:"
  move = gets.strip.to_i
  valid_move?(board, move.to_s)
  while !move.between?(1,9) || position_taken?(board, move)
    puts "Please enter 1-9:"
    move = gets.strip.to_i
  end
  move(board, move)
  display_board(board)
end

def won?(board)
  if empty?(board)
    return false
  end

  WIN_COMBINATIONS.each do |combination|
    win_index_1 = combination[0]
    win_index_2 = combination[1]
    win_index_3 = combination[2]

    position1 = board[win_index_1]
    position2 = board[win_index_2]
    position3 = board[win_index_3]

    if position1 == "X" && position2 == "X" && position3 == "X"
      return combination
    elsif position1 == "O" && position2 == "O" && position3 == "O"
      return combination
    else
     false
    end
  end

  return false
end

def full?(board)
  !(board.include?("") || board.include?(" "))
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end

end

def over?(board)
  if draw?(board)
    return true
  elsif won?(board)
    return true
  else
    false
  end
end

def empty?(board)
  all_empty = board.all? do |position|
    position == "" || position == " "
  end
  all_empty
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    nil
  end
end

def turn_count(board)
  turn_count = 0
  board.each do |position|
    if position == "X" || position == "O"
      turn_count += 1
    end
  end
  turn_count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end
