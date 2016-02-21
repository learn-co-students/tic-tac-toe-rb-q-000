WIN_COMBINATIONS = [
	[0,1,2], # Top row
	[3,4,5], # Middle row
	[6,7,8], # bottom row
	[0,4,8], # diag left top to bottom right
	[6,4,2], # top right bottom left
	[0,3,6], # 1st column
	[1,4,7], # 2nd column
	[2,5,8], # 3rd column
	# an array for each win combination
]

def display_board(board)
	puts " #{board[0]} | #{board[1]} | #{board[2]} "
	puts "-----------"
	puts " #{board[3]} | #{board[4]} | #{board[5]} "
	puts "-----------"
	puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board,location, player=X)
	board[location.to_i-1] = player
end

def position_taken?(board, location)
	board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
	position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
	puts "\n\nPlease enter 1-9:\n\n"
	input = gets.strip
	if valid_move?(board, input)
		move(board, input, current_player(board))
	else
		puts "You're killing me Smalls! Try again.\n" # Late night coloring
		turn(board)
	end
	display_board(board)
end

def turn_count(board)
	board.count{|player| player == "X" || player == "O"}
end

def current_player(board)
	turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
	WIN_COMBINATIONS.detect do |combo|
		(board[combo[0]] == board[combo[1]]) && (board[combo[0]] == board[combo[2]]) && ((board[combo[0]] == "X") || (board[combo[0]] == "O"))
	end
end

def full?(board)
	board.all?{|player| player == "X" || player == "O"}
end

def draw?(board)
	!won?(board) && board.all?{|player| player == "X" || player == "O"}
end

def over?(board)
	won?(board) || draw?(board) || full?(board)
end

def winner(board)
	won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
	while !over?(board)
		turn(board)
	end
	if won?(board)
		puts "\n\nWhoa! I was definitely not betting on you for the win." # Late night coloring
		puts "Congratulations #{winner(board)}!"
	elsif draw?(board)
		puts "\n\nUggh, two losers." # Late night coloring
		puts "Cats Game!"
	end
end
