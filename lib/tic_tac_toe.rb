WIN_COMBINATIONS = [
	[0, 1, 2],
	[0, 3, 6],
	[0, 4, 8],
	[1, 4, 7],
	[2, 5, 8],
	[2, 4, 6],
	[3, 4, 5],
	[6, 7, 8]
]

def display_board(board)
	puts " #{board[0]} | #{board[1]} | #{board[2]} "
  	puts "-----------"	
	puts " #{board[3]} | #{board[4]} | #{board[5]} "
  	puts "-----------"	
	puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, token = "X") 
	board[position.to_i-1] = token
end

# position is a value from 0-8 according to rspec test
def position_taken?(board, position) 
	board[position] != " "
end

def valid_move?(board, position)
	board[position.to_i-1] == " " &&  position.to_i.between?(1, 9)
end

def turn_count(board)
	board.select{|position| position != " "}.length
end

def current_player(board) 
	turn_count(board) % 2 == 0 ? "X": "O"
end

def turn(board)
	puts "Please enter 1-9:"
	input = gets.strip
	valid_move?(board, input) ? move(board, input, current_player(board)) : turn(board)
   	display_board(board)	
end

def won?(board)
	WIN_COMBINATIONS.detect{|combo| 
		pos_1 = board[combo[0]]
		pos_2 = board[combo[1]]
		pos_3 = board[combo[2]]

		(pos_1 == "X" && pos_2 == "X" && pos_3 == "X") || (pos_1 == "O" && pos_2 == "O" && pos_3 == "O") ? combo : false
	}
end

def full?(board) 
	board.select{|position| position == " "}.length == 0
end

def draw?(board)
	!won?(board) && full?(board)
end

def over?(board)
	full?(board) || draw?(board) || won?(board)
end

def winner(board)
	won?(board) ? board[won?(board)[0]]: nil
end

def play(board)
	until over?(board)
		turn(board)
	end

	puts winner(board) ? "Congratulations #{winner(board)}!" : "Cats Game!"
end
