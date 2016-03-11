def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  who = current_player(board)
  until valid_move?(board, input)
    puts "invalid"
    input = gets.strip
	end
  move(board, input, who)
	display_board(board)
end

def turn_count(board)
	occupied = 0
	board.each do | square |
		if square == "X" || square == "O"
			occupied += 1
		end
	end
	puts "#{occupied}"
	occupied
end

def current_player(board)
	turn_count(board).odd? ?	"O"	: "X"
end

# Define your play method below
def play(board)
 #input = gets.strip
 until over?(board)
 	turn(board)
 if won?(board)
 	puts "Congratulations #{winner(board)}!"
 end
 if draw?(board)
	puts "Cats Game!"
 end
 end

end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won?(board)
	WIN_COMBINATIONS.each do |combi|
		if position_taken?(board, combi[0]) && board[combi[0]] == board[combi[1]] && board[combi[1]] == board[combi[2]]
		return combi
		end
	end
	false
end

def full?(board)
 	[0,1,2,3,4,5,6,7,8].all? { |i| position_taken?(board, i)  }
end

def draw?(board)
	#puts "in draw?"
	!won?(board) && full?(board)
end

def over?(board)
	won?(board) || full?(board)
end

def winner(board)
	combi = won?(board)
	if combi
		return board[combi[0]]
	end
	nil
end

