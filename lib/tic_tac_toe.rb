WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(array, position, character = "X")
	array[position.to_i - 1] = character
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
  	return false
  else
  	return true
  end
end

def valid_move?(board, position)
  if position_taken?(board, position.to_i - 1) == true or (position.to_i - 1).between?(0, 8) == false
  	return false
  elsif board[position.to_i] == " " or board[position.to_i] == ""
  	return true
  end
end


def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position) == false
    turn(board)
  else
  	move(board, position, current_player(board))
  	display_board(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |position| 
    if position == "X" or position == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
  	return "X"
  else 
    return "O"	
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |combination|
    combination.all? { |position| board[position] == "X" } or combination.all? { |position| board[position] == "O" }
  end
end

def full?(board) 
  !board.any? { |position| position != "X" && position != "O" }
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else 
    return false
  end
end

def over?(board)
  if won?(board) or full?(board) or draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board) do
  	turn(board)
  end
  if over?(board)
  	if won?(board)
  	  puts "Congratulations #{winner(board)}!"
  	elsif draw?(board)
  	  puts "Cats Game!"
  	end
  end
end

