# Define your WIN_COMBINATIONS constant
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

#display_board method
def display_board(array)

  puts " #{array[0]} | #{array[1]} | #{array[2]}  "
  puts "-----------"
  puts " #{array[3]} | #{array[4]} | #{array[5]}  "
  puts "-----------"
  puts " #{array[6]} | #{array[7]} | #{array[8]}  "

end

#move method
def move(array, loc, choice = "X")
  loc = loc.to_i
  array[loc-1] = choice
end

#position_taken? method
def position_taken?(board, position)

  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  elsif board[position] == "X" || board[position] == "O"
    true
  end
end

#valid_move? method
def valid_move?(board, position)
  position = position.to_i
  if position_taken?(board, position-1)
    false
  elsif position.between?(1,9) == false
    false
  else
    true
  end
end

#turn method
def turn(board)

  puts "Please enter 1-9:"
  input = gets.strip

  if valid_move?(board, input)
    move(board, input, current_player(board))
    display_board(board)
  else
    while (input.to_i).between?(1,9) == false
      puts "Please enter 1-9:"
      input = gets.strip
    end
  end
end

#turn_count method
def turn_count(board)
  count = 0

  board.each do|position|
    if position == "X" || position == "O"
      count += 1
    end
  end

  return count
end

#current_player method
def current_player(board)

  if turn_count(board) % 2 == 0
    return "X"
  elsif turn_count(board) % 2 == 1
    return "O"
  end
end

#won? method
def won?(board)

  WIN_COMBINATIONS.each do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return combo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return combo
    end
  end
  return false
end

#full? method
def full?(board)

  board.all? do |move|
    move == "X" || move == "O"
  end
end

#draw? method
def draw?(board)
  if !won?(board) && full?(board)
    return true
  elsif !won?(board) && !full?(board)
    return false
  elsif won?(board)
    return false
  end
end

#over? method
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

#winner method
def winner(board)

  array = won?(board)

  if won?(board) != false
    if board[array[0]] == "X"
      return "X"
    elsif board[array[0]] == "O"
      return "O"
    end
  elsif draw?(board)
    return nil
  end
end

#play method
def play(board)

  until over?(board)
     turn(board)
  end

  if won?(board)
    puts "#{winner(board)} wins! Congratulations!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end