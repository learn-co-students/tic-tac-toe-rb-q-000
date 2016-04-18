#WIN_COMBINATIONS

WIN_COMBINATIONS = 	[
		[0, 1, 2],
		[3, 4, 5],
		[6, 7, 8],
		[0, 3, 6],
		[1, 4, 7],
		[2, 5, 8],
		[0, 4, 8],
		[2, 4, 6]
	]

# Define display_board that accepts a board and prints
# out the current state.
	
board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
def display_board(board)
	puts " #{board[0]} " + "|" +  " #{board[1]} " + "|" + " #{board[2]} " + 
	"\n-----------\n" + 
	" #{board[3]} " + "|" +  " #{board[4]} " + "|" + " #{board[5]} " + 
	"\n-----------\n"  +
	" #{board[6]} " + "|" +  " #{board[7]} " + "|" + " #{board[8]} " 
end

# code your move method here!
def move(board, position, character = "X")
	 board[position.to_i - 1] = character
end

# code your #position_taken? method here!
def position_taken?(board, position)
	if board[position] == " " || board[position] == ""
		return false
	elsif board[position] == nil
		return false
			else 
				return true
			
	end
end

# code your #valid_move? method here
def valid_move?(board, position)
	  position.to_i.between?(1,9) and !position_taken?(board, position.to_i - 1)
		end
	def position_taken?(board, position)
	if board[position] == " " || board[position] == ""
		return false
	elsif board[position] == nil
		return false
			else 
				return true
			
	end
end

def turn(board)
	puts "Please enter 1-9:"
	input = gets.strip

	if valid_move?(board, input)
		move(board, input)
		display_board(board)
	else
		turn(board)
	end	
end

def turn_count(board)
	counter = 0
	board.each do |position|
		if position == "X" || position == "O"
		counter += 1
		end
	end
	counter
end

def current_player(board)
	if turn_count(board).even? 
	"X"
	else
	"O"
	end
	
end

def won?(board)
	WIN_COMBINATIONS.find do |combo| 
		board[combo[0]] == board[combo[1]] && 
		board[combo[1]] == board[combo[2]] && 
		position_taken?(board, combo[0])
	end
end

def full?(board)
	board.all? {|character| character == "X" || character == "O"}
end

def draw?(board)
	if won?(board)
		return false
	elsif full?(board)
		return true
	end
end

def over?(board)
	won?(board) || full?(board) || draw?(board)
end

def winner(board)
	if combo_winner = won?(board)
		board[combo_winner.first]

	end
end

# Define your play method below
def play(board)
 while !over?(board)
 	turn(board)
end
  	if won?(board)
  		puts "Congratulations #{winner(board)}!"
  	elsif draw?(board)
  		puts "Cats Game!"
  	end
end





