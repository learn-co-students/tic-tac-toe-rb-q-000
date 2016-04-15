# Helper Method

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn_count(board)
	count = 0
	board.each do |position|
		count += 1 if (position == 'X') or (position == 'O')
	end
	count
end

def current_player(board)
	turn_count(board).even? ? "X" : "O"
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end


# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]



def won?(board)
	WIN_COMBINATIONS.each_with_index do |win_combination, index|
	  # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
	  # grab each index from the win_combination that composes a win.
	  win_index_1 = win_combination[0]
	  win_index_2 = win_combination[1]
	  win_index_3 = win_combination[2]
	 
	  position_1 = board[win_index_1] # load the value of the board at win_index_1
	  position_2 = board[win_index_2] # load the value of the board at win_index_2
	  position_3 = board[win_index_3] # load the value of the board at win_index_3
	 
	  return win_combination if (position_1 == 'X'  or position_1 = 'O') and (position_1 == position_2 and position_2 == position_3)
	end
	false
end

def full?(board)
	turn_count(board) == 9
end

def draw?(board)
	return false if won?(board)
	full?(board)
end


def over?(board)
	return true if won?(board) or full?(board) or draw?(board)
	false
end

def winner(board)
	win_combination = won?(board)
	if win_combination
		board[win_combination[0]]
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



