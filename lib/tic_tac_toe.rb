# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
	[0,1,2], #Top Row
	[3,4,5], #Middle Row
	[6,7,8], #Bottom Row
	[0,3,6], #Left Column
	[1,4,7], #Middle Column
	[2,5,8], #Right Column
	[0,4,8], #Top Left to Bottom Right
	[2,4,6]  #Top Right to Bottom Left
]

#Display Board
def display_board(board)
	puts " #{board[0]} | #{board[1]} | #{board[2]} "
	puts "------------"
	puts " #{board[3]} | #{board[4]} | #{board[5]} "
	puts "------------"
	puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Turns user input into accurate index
def input_to_index(user_input)
	user_input.to_i - 1
end

#Place player character on board in specified position
def move(board, index, character)
	board[index] = character
end

#Make sure user move can be made.
def valid_move?(board, index)
	index.between?(0,8) && !position_taken?(board, index)
end

#Make One valid turn cycle
def turn(board)
	puts "Where do you want to move? (1-9):"
	user_input = gets.strip
	index = input_to_index(user_input)
	if valid_move?(board, index)
		move(board, index, character = "X")
		display_board(board)
	else
		puts "Invalid move."
		turn(board)
	end
end

#Use number of characters on board to determine turn count
def turn_count(board)
	counter = 0
	board.each do |position|
		if position == "X" || position == "O"
			counter += 1
		end
	end
	return counter
end

#Use turn_count to determine current player
def current_player(board)
	unless turn_count(board) == 0 || turn_count(board) % 2 == 0
		return "O"
	else
		return "X"
	end
end

def won?(board)
	WIN_COMBINATIONS.detect do |win_combination|
		board[win_combination[0]] == board[win_combination[1]] &&
		board[win_combination[1]] == board[win_combination[2]] &&
		position_taken?(board, win_combination[0])
	end
end

def full?(board)
	board.all? do |spot|
		spot == "X" || spot == "O"
	end
end

def draw?(board)
	won?(board) && full?(board)
end

