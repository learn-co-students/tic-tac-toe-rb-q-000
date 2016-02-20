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

def move(board, position, value="X")
  position = position.to_i
  position -= 1
  board[position] = value
  display_board(board)
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.chomp
  if valid_move?(board, position)
    move(board, position, current_player(board))
  else
    puts "That is not a valid move;"
    turn(board)
  end
end

def turn_count(board)
  number_of_turns = 0
  board.each do |position|
    if position.to_s != "" && position.to_s != " "
      number_of_turns += 1
    end
  end
  number_of_turns
end

def current_player(board)
  turn_counter = turn_count(board)
  if turn_counter % 2 == 0 || turn_counter == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_taken?(board, win_index_1) && position_taken?(board, win_index_2) && position_taken?(board, win_index_3)
      if (position_1 == "X" and position_2 == "X" and position_3 == "X") || (position_1 == "O" and position_2 == "O" and position_3 == "O")
        return win_combination
      else
        false
      end
      false
    end
    false
  end
  false
end

def full?(board)
  if (board.all? {|space| space == "X" or space == "O"})
    true
  else
    false
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  elsif won?(board)
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  winning_index = won?(board)
  if won?(board)
    if board[winning_index[0]] == "X" and board[winning_index[1]] == "X" and board[winning_index[2]] == "X"
      "X"
    elsif board[winning_index[0]] == "O" and board[winning_index[1]] == "O" and board[winning_index[2]] == "O"
      "O"
    end
  else
    nil
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    if current_player(board) == "X"
      puts "Congratulations O!"
    elsif current_player(board) == "O"
      puts "Congratulations X!"
    end
  elsif draw?(board)
    puts "Cats Game!"
  end
end