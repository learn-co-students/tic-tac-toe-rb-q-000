WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]



def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end



def move(board, input, character = "X")
  board[input.to_i - 1] = character
end



def position_taken?(board, position)
  if "#{board[position.to_i]}" == " "
    false
  else
    true
  end
end



def position_taken_2?(board, position)
  if "#{board[position.to_i - 1]}" == "X"
    false
  else
    true
  end
end



def valid_move?(board, position)
  if position.to_i.between?(1, 9) && position_taken_2?(board, position)
    true
  else
    false
   end
end



def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position) == true
    move board, position, current_player(board)
  else valid_move?(board, position) == false
    turn(board)
  end
  display_board(board)
end



def turn_count(board)
  count = 0
  if "#{board[0]}" != " "
  count += 1
  end
  if "#{board[1]}" != " "
  count += 1
  end
  if "#{board[2]}" != " "
  count += 1
  end
  if "#{board[3]}" != " "
  count += 1
  end
  if "#{board[4]}" != " "
  count += 1
  end
  if "#{board[5]}" != " "
  count += 1
  end
  if "#{board[6]}" != " "
  count += 1
  end
  if "#{board[7]}" != " "
  count += 1
  end
  if "#{board[8]}" != " "
  count += 1
  end
  "#{count}".to_i
end



def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end



def won?(board)
  if "#{board[0]}" == "X" && "#{board[1]}" == "X" && "#{board[2]}" == "X" || "#{board[0]}" == "O" && "#{board[1]}" == "O" && "#{board[2]}" == "O"
  true
  elsif "#{board[3]}" == "X" && "#{board[4]}" == "X" && "#{board[5]}" == "X" || "#{board[3]}" == "O" && "#{board[4]}" == "O" && "#{board[5]}" == "O"
  true
  elsif "#{board[6]}" == "X" && "#{board[7]}" == "X" && "#{board[8]}" == "X" || "#{board[6]}" == "O" && "#{board[7]}" == "O" && "#{board[8]}" == "O"
  true
  elsif "#{board[0]}" == "X" && "#{board[3]}" == "X" && "#{board[6]}" == "X" || "#{board[0]}" == "O" && "#{board[3]}" == "O" && "#{board[6]}" == "O"
  true
  elsif "#{board[1]}" == "X" && "#{board[4]}" == "X" && "#{board[7]}" == "X" || "#{board[1]}" == "O" && "#{board[4]}" == "O" && "#{board[7]}" == "O"
  true
  elsif "#{board[2]}" == "X" && "#{board[5]}" == "X" && "#{board[8]}" == "X" || "#{board[2]}" == "O" && "#{board[5]}" == "O" && "#{board[8]}" == "O"
  true
  elsif "#{board[0]}" == "X" && "#{board[4]}" == "X" && "#{board[8]}" == "X" || "#{board[0]}" == "O" && "#{board[4]}" == "O" && "#{board[8]}" == "O"
  true
  elsif "#{board[2]}" == "X" && "#{board[4]}" == "X" && "#{board[6]}" == "X" || "#{board[2]}" == "O" && "#{board[4]}" == "O" && "#{board[6]}" == "O"
  true
  end
end



def full?(board)
  board.all? do |position|
    position != " "
  end
end



def draw?(board)
  if "#{board[0]}" == "X" && "#{board[1]}" == "X" && "#{board[2]}" == "X" || "#{board[0]}" == "O" && "#{board[1]}" == "O" && "#{board[2]}" == "O"
  false
  elsif "#{board[3]}" == "X" && "#{board[4]}" == "X" && "#{board[5]}" == "X" || "#{board[3]}" == "O" && "#{board[4]}" == "O" && "#{board[5]}" == "O"
  false
  elsif "#{board[6]}" == "X" && "#{board[7]}" == "X" && "#{board[8]}" == "X" || "#{board[6]}" == "O" && "#{board[7]}" == "O" && "#{board[8]}" == "O"
  false
  elsif "#{board[0]}" == "X" && "#{board[3]}" == "X" && "#{board[6]}" == "X" || "#{board[0]}" == "O" && "#{board[3]}" == "O" && "#{board[6]}" == "O"
  false
  elsif "#{board[1]}" == "X" && "#{board[4]}" == "X" && "#{board[7]}" == "X" || "#{board[1]}" == "O" && "#{board[4]}" == "O" && "#{board[7]}" == "O"
  false
  elsif "#{board[2]}" == "X" && "#{board[5]}" == "X" && "#{board[8]}" == "X" || "#{board[2]}" == "O" && "#{board[5]}" == "O" && "#{board[8]}" == "O"
  false
  elsif "#{board[0]}" == "X" && "#{board[4]}" == "X" && "#{board[8]}" == "X" || "#{board[0]}" == "O" && "#{board[4]}" == "O" && "#{board[8]}" == "O"
  false
  elsif "#{board[2]}" == "X" && "#{board[4]}" == "X" && "#{board[6]}" == "X" || "#{board[2]}" == "O" && "#{board[4]}" == "O" && "#{board[6]}" == "O"
  false
  elsif "#{board[0]}" == " " || "#{board[1]}" == " " || "#{board[2]}" == " " || "#{board[3]}" == " " || "#{board[4]}" == " " || "#{board[5]}" == " " || "#{board[6]}" == " " || "#{board[7]}" == " " || "#{board[8]}" == " "
  false
  else
  true
end
end



def over?(board)
  if "#{board[0]}" == " " || "#{board[1]}" == " " || "#{board[2]}" == " " || "#{board[3]}" == " " || "#{board[4]}" == " " || "#{board[5]}" == " " || "#{board[6]}" == " " || "#{board[7]}" == " " || "#{board[8]}" == " "
  false
  else
  true
  end
end



def winner(board)
  if "#{board[0]}" == "X" && "#{board[1]}" == "X" && "#{board[2]}" == "X" || "#{board[3]}" == "X" && "#{board[4]}" == "X" && "#{board[5]}" == "X" || "#{board[6]}" == "X" && "#{board[7]}" == "X" && "#{board[8]}" == "X" || "#{board[0]}" == "X" && "#{board[3]}" == "X" && "#{board[6]}" == "X" || "#{board[1]}" == "X" && "#{board[4]}" == "X" && "#{board[7]}" == "X" || "#{board[2]}" == "X" && "#{board[5]}" == "X" && "#{board[8]}" == "X" || "#{board[0]}" == "X" && "#{board[4]}" == "X" && "#{board[8]}" == "X" || "#{board[2]}" == "X" && "#{board[4]}" == "X" && "#{board[6]}" == "X"
  "X"
elsif "#{board[0]}" == "O" && "#{board[1]}" == "O" && "#{board[2]}" == "O" || "#{board[3]}" == "O" && "#{board[4]}" == "O" && "#{board[5]}" == "O" || "#{board[6]}" == "O" && "#{board[7]}" == "O" && "#{board[8]}" == "O" || "#{board[0]}" == "O" && "#{board[3]}" == "O" && "#{board[6]}" == "O" || "#{board[1]}" == "O" && "#{board[4]}" == "O" && "#{board[7]}" == "O" || "#{board[2]}" == "O" && "#{board[5]}" == "O" && "#{board[8]}" == "O" || "#{board[0]}" == "O" && "#{board[4]}" == "O" && "#{board[8]}" == "O" || "#{board[2]}" == "O" && "#{board[4]}" == "O" && "#{board[6]}" == "O"
  "O"
else
nil
end
end



def play(board)
until over?(board) || won?(board) || draw?(board)
turn_count(board)
current_player(board)
turn(board)
end
if winner(board) == "X"
  puts "Congratulations X!"
elsif winner(board) == "O"
  puts "Congratulations O!"
elsif draw?(board) == true
  puts "Cats Game!"
end
end