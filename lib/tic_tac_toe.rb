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


def move (board, input, character = current_player)
		position = input.to_i - 1
		board[position] = character
end


def position_taken?(board, position)
	!(board[position] == " " || board[position]  == "" || board[position] == nil)
end


def valid_move?(board, position)
	input = position.to_i
	input.between?(1, 9) == true && position_taken?(board, position.to_i - 1) == false
end


def turn(board)
	puts "Please enter 1-9:"
	position = gets.strip
	if valid_move?(board, position) == true
		character = current_player(board)
		move(board, position, character)
		display_board(board)
	else
			turn(board)		
	end
end


def turn_count(board)
	counter = 0
	board.each do |turn|
		if turn == "X" || turn == "O"
			counter += 1
		end
	end 
	return counter
end


def current_player(board)
	return (turn_count(board).even? ? 'X' : 'O')
end


def won?(board)
	WIN_COMBINATIONS.each do | win_combination|
  		win_index_1 = win_combination[0]
  		win_index_2 = win_combination[1]
  		win_index_3 = win_combination[2]

  		position_1 = board[win_index_1]
  		position_2 = board[win_index_2] 
  		position_3 = board[win_index_3]
				
		if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
			return win_combination
		end
	end
	return false
end


def full?(board)
	board.all?{|i| i == "X" || i == "O"}
end


def draw?(board)
	!(won?(board)) && (full?(board))
		
end


def over?(board)
	won?(board) || draw?(board)
	
end


def winner(board)
	if won?(board) 
		return board[won?(board)[0]]
	end
end


def play(board)
	until over?(board)
		turn(board) 
	end

	if won?(board)
		puts "Congratulations #{winner(board)}!"
	else
		puts "Cats Game!"	
	end
	
end