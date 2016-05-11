# Helper Methods

#Define a constant in lib/tic_tac_toe.rb WIN_COMBINATIONS
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Right diagonal
  [2,4,6]  # Left diagonal
]

# Define a method display_board that prints a 3x3 Tic Tac Toe Board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
# code your move method here!
def move(board, input, value )
  board[input.to_i - 1] = value
end
# code your #position_taken? method here!
def position_taken?(board, location)
  location=location.to_i
  board[location] != " " && board[location] != ""
end

# code your #valid_move? method here
def valid_move?(board, location)
  location=location.to_i-1
  location.between?(0,8) && !position_taken?(board, location)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  while !valid_move?(board,input)
    turn(board)
  end
   if current_player(board).to_s=="X"
    move(board, input,"X")
    display_board(board)
   elsif current_player(board).to_s=="O"
    move(board, input,"O")
    display_board(board)
  end
end

def turn_count(board)

  board.each  do |player|
    counter = 0
     x = board.count "X"
     o = board.count "O"
     counter= x+o
    return counter

  end
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end
def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
		win_index1= win_combination[0]
		win_index2= win_combination[1]
		win_index3= win_combination[2]
		pos_1 = board[win_index1]
		pos_2 = board[win_index2]
		pos_3 = board[win_index3]

	   if (pos_1 == "X" && pos_2 == "X" && pos_3 == "X")
	      return win_combination
		end
    if  (pos_1 == "O" && pos_2 == "O" && pos_3 == "O")
	        return win_combination
	      end
	 	end

		return false
end

def full?(board)
  !board.any? {|element| (element ==" ") || (element =="")}
end
def draw?(board)

  if won?(board)||(!won?(board)&&!full?(board))
    return false
  elsif full?(board) && !won?(board)
    return true

  end
end
def over?(board)
  if won?(board)||full?(board)||draw?(board)
    return true
  end
end


def winner(board)
	if win_combination = won?(board)
	  board[win_combination.first]
  end
end
# Define your play method below
def play(board)
  count=1
  until count == 10
    if over?(board)
       break
    end

    turn(board)
    count+=1
   	if won?(board)||draw?(board)
    	break
    end

  end
    winner(board)
    if won?(board)
        puts "Congratulations #{winner(board)}!"
      elsif draw?(board)
        puts "Cats Game!"
      end


end
