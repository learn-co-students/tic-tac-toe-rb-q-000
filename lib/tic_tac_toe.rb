# Define your WIN_COMBINATIONS constant
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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
	input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  current_player = current_player(board)
  if valid_move?(board, index)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def current_player(board)
	turn_count(board).even? ? "X" : "O"
end

def turn_count(board)
  count = 0
  board.each do |index|
    if index == "X" or index == "O"
    count += 1
    end
  end
  count
end

def won?(board)
  won_combo = nil

  WIN_COMBINATIONS.each do |combo|
    position_1 = combo[0]
    position_2 = combo[1]
    position_3 = combo[2]

    if board[position_1] == "X" && board[position_2] == "X" && board[position_3] == "X"
      won_combo = combo
    elsif board[position_1] == "O" && board[position_2] == "O" && board[position_3] == "O"
      won_combo = combo
    end
  end
  won_combo
end

def full?(board)
	board.all? {|e| e == "X" || e == "O"}
end

def draw?(board)
	full?(board) && !won?(board)
end

def over?(board)
	won?(board) || draw?(board) || full?(board)
end

def winner(board)
	won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
	until over?(board)
		turn(board)
  end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
end
