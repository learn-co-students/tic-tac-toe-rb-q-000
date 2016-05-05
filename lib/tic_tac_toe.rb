WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(array, position, value)
  position = position.to_i - 1
  array[position] = value
  display_board(array)
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position = position.to_i - 1
  if position.between?(0,8)
    if !position_taken?(board, position)
      true
    end
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip

  while !valid_move?(board, position)
    puts "Please enter 1-9:"
    position = gets.strip
  end
  value = current_player(board)
  move(board, position, value)
  display_board(board)
end

def turn_count(board)
  acc = 0
  board.each do |token|
    if token == "X" || token == "O"
    	acc += 1
    end
  end
  acc
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end


def won?(board)
	row = []
	WIN_COMBINATIONS.each do |win_combos|

		row[0] = board[win_combos[0]]
		row[1] = board[win_combos[1]]
		row[2] = board[win_combos[2]]

		if row.all? {|token| token == "X"} || row.all? {|token| token == "O"}
			return win_combos
		end
	end
	return false
end

def full?(board)
	board.all? do |pos|
		pos == "X" || pos == "O"
	end
end

def draw?(board)
	!won?(board) && full?(board) ? true : false
end

def over?(board)
	(won?(board) || full?(board) || draw?(board)) ? true : false
end

def winner(board)
	token_array = []
	if won?(board)
		token_array = won?(board)
		token = token_array[0]
		return board[token]
	end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    the_winner = winner(board)
    puts "Congratulations #{the_winner}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
