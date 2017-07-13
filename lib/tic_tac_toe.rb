  WIN_COMBINATIONS = [	[ 0, 1, 2 ], # left to rights
			[ 3, 4, 5 ],
			[ 6, 7, 8 ],
			[ 0, 4, 8 ], #diagonals
			[ 2, 4, 6 ],
			[ 0, 3, 6 ], #ups and downs
			[ 1, 4, 7 ],
			[ 2, 5, 8 ]  ]
board = [" ", " ", " ", " ", " ", " ", " ", " ", " " ]
def display_board(boardState)
	board = boardState
	puts " #{board[0] } | #{board[1] } | #{board[2] } " 
	puts "-----------"
	puts " #{board[3] } | #{board[4] } | #{board[5] } " 
	puts "-----------"
	puts " #{board[6] } | #{board[7] } | #{board[8] } " 
end

def input_to_index(index)
	index = index.to_i - 1
end

def move( board, input, character)
	board[input] = character
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?( board, index)
	position_taken?(board, index) == false && index.between?(0,8) == true ? true : false
end

def turn(board)
  puts "Please enter 1-9:"
index = input_to_index(gets.strip)
valid_move?(board, index) == true ? move(board, index, current_player(board)) && display_board(board) : turn(board)
end

def turn_count(board)
	board.count{ |x| x if x == "X" || x == "O" }
end

def current_player(board)
	turn_count(board) % 2 == 0 ? "X" : "O"	
end

def won?(board) #compares board to winning combinations
				    win_combination = WIN_COMBINATIONS.find { |combo| board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X" || board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"}
end

def full?(board)
	board.all? { |position| position == "X" || position == "O" } #Return true for full board	
end

def draw?(board)
	!won?(board) && full?(board) ? true : false
end

def over?(board)
	won?(board) || full?(board) || draw?(board) ? true : false
end

def winner(board)
	combo = won?(board)
	combo != nil ? board[combo[0]] : nil #board contains the letter/winner and combo is simple the integers/indexes
end

def play(board)

	while !over?(board)
	turn(board)
	end

	if (draw?(board) == true) 
	puts "Cats Game!"
	else puts "Congratulations #{winner(board)}!"
	end 
end


