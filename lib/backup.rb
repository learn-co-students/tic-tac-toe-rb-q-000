#Board Helper Method
def display_board(board)
	puts " #{board[0]} | #{board[1]} | #{board[2]} "
	puts "-----------"
	puts " #{board[3]} | #{board[4]} | #{board[5]} "
	puts "-----------"
	puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Move Helper Method
def move(board, position, value = "X")
	position = position.to_i
	board[position-1] = value
end

def turn_count(board)
	count = 0
	board.each do |turn|
		if turn == "X" or turn == "O"
			count += 1
		end
	end
	count
end
def current_player(board)
	if turn_count(board).to_i.even?
		"X"
	else 
		"O"
	end
end


# Position Taken Helper Method
def position_taken?(board, location)
	!(board[location].nil? || board[location] == " ")
end

#Valid Move Helper Method
def valid_move?(board, position)
	position = position.to_i - 1
	if position_taken?(board, position) == false && position <= 8
		return true
	else
		return false
	end
	# !position_taken?(board, position) && position <= 8
end	

#WIN_COMBINATIONS constant
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

#Won Helper Method
def won?(board)

	WIN_COMBINATIONS.detect do |win_combination|

		win_index_1 = win_combination[0]
		win_index_2 = win_combination[1]
		win_index_3 = win_combination[2]

		position_1 = board[win_index_1]
		position_2 = board[win_index_2]
		position_3 = board[win_index_3]

		if
			position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 =="O"
			return win_combination

		end
	end
end

#Full Board Helper Method
def full?(board)
	board.all? do |cell|
		cell == "X" || cell == "O"
	end
end

#Draw Board Helper Method
def draw?(board)
	if won?(board) == nil && full?(board) == true
		return true
	end
end

#Game Over Helper Method
def over?(board)
	if draw?(board) == true
		return true

	elsif won?(board)
		return true
	end
end

#Who Won Helper Method
def winner(board)
	if won?(board) != nil
		won?(board).each do |win_num|
			return board[win_num][0]
		end
	end
end

def turn(board)
	puts "Enter 1-9"
	input = gets.strip

	if valid_move?(board, input) == true
		move(board, input, value=current_player(board))
	elsif valid_move?(board, input) == false
		puts "Please choose an empty square"
	end
	display_board(board)
end

#Game Play
def play(board)

	while full?(board) != true

		until over?(board) == true
			turn(board)
		end
		if winner(board) != nil
			puts "Player #{winner(board)} wins!"
			exit
		else 
			puts "Cats Game!"
			exit
		end
	end
end











	


