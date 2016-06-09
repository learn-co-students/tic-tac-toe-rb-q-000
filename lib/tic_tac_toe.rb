WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Diagonal top left to bottom right
  [2,4,6]  # Diagonal bottom left to top right
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(move)
  board_move = move.to_i
  board_move - 1
end

def move(board, board_move, player)
  board[board_move] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    if index.between?(0, 8)
      true
    end
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  spaces_full = 0
  board.each do |space|
    if space != "" && space != " "
      spaces_full += 1
    end
  end
  return spaces_full
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    first_position_to_check = combination[0]
    second_position_to_check = combination[1]
    third_position_to_check = combination[2]

    position_1 = board[first_position_to_check]
    position_2 = board[second_position_to_check]
    position_3 = board[third_position_to_check]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return combination # return the win_combination indexes that won.
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return combination # return the win_combination indexes that won.
    end
  end
  return false
end

def full?(board)
  board.each do |index|
    if index == "" || index == " "
      return false
    end
  end
  return true
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  elsif (won?(board))
    return false
  else
    return false
  end
end

def over?(board)
  if full?(board) == true || draw?(board) == true || won?(board) != false
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) == false
    return nil
  else
    winning_combination = won?(board)
    if board[winning_combination[0]] == "X"
      return "X"
    elsif board[winning_combination[0]] == "O"
      return "O"
    end
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end

  if won?(board) != false
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board) == true
    puts "Cats Game!"
  end
end
