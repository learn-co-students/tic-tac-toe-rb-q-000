WIN_COMBINATIONS =[
[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[2,4,6],
]

def display_board(board)
	puts " #{board[0]} | #{board[1]} | #{board[2]} "
	puts "-----------"
	puts " #{board[3]} | #{board[4]} | #{board[5]} "
	puts "-----------"
	puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, place = "X")
  board[position.to_i-1] = place
end

def position_taken?(board, position)
	if board[position] == "X"
		return true
	elsif board[position] == "O"
		return true
	elsif board[position] == " " || "" || nil
		return false
	end
end

def valid_move?(board, position)
  if (1..9).include?(position.to_i) && !(position_taken?(board, position.to_i - 1))
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position) == false
    puts "Sorry, that is not a valid move."
    turn(board)
  else move(board, position, current_player(board))
    display_board(board)
  end
end

def turn_count(board)
	counter = 0
	board.each do |place|
		if place == "X" || place == "O"
			counter += 1
		end
	end
	return counter
end

def current_player(board)
	if turn_count(board) % 2 == 0
		return "X"
	elsif turn_count(board) % 2 == 1
		return "O"
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

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
    end
	end
	false
end

def full?(board)
	if board.any?{|value| value == " "}
  		return false
	else
		return true
	end
end

def draw?(board)
	if won?(board) == true
		return false
	elsif !won?(board) && full?(board)
		return true
	elsif !won?(board) && !full?(board)
		return false
	end
end

def over?(board)
	if won?(board) || draw?(board) || full?(board)
		return true
	end
end

def winner(board)
  if won?(board) == false
    nil
  elsif board[won?(board)[0]] == "X"
    return "X"
  elsif board[won?(board)[0]] == "O"
   	return "O"
  end
end

def play(board)
  until over?(board)
    turn(board)
    turn_count(board)
  end
  if over?(board)
    if won?(board)
      return puts "Congratulations #{winner(board)}!"
    else
      return puts "Cats Game!"
    end
  end
end








