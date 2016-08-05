
require 'pry'

# WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
	[0,1,2], #Top row
	[3,4,5], #Middle row
	[6,7,8], #Bottem row
	[0,3,6], #Left column
	[1,4,7], #Middle column
	[2,5,8], #Right column
	[0,4,8], #Top left to bottom right
	[2,4,6]  #Top right to bottom left
]

# Helper Methods
def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn_count(board)
	couter =  board.select{|charector| charector == "X" || charector == "O"}
	couter.size
end

def current_player(board)
	turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |item|
  	#------------------in progress to make it work-------
  	# i = board.values_at(item[0], item[1], item[2]).uniq
    # if i[0] == "X" || i[0] == "O"
    # 	return item
    # end
    #------------------as of now this will suffice-----------------------------
  	if board[item[0]] == "X" && board[item[1]] == "X" && board[item[2]] == "X"
      return item
    elsif board[item[0]] == "O" && board[item[1]] == "O" && board[item[2]] == "O"
      return item
    end
  end
  else 
  	false
end

def full?(board)
    board.all?{|element| element == "X" || element == "O"}
end

def draw?(board)	 		
	if won?(board) && full?(board)
	    false
	elsif full?(board) 
	    true	
	end	
end

def over?(board)
	if full?(board)
		true
	elsif draw?(board)
		true
	elsif won?(board)
		true 	
	end
end

def winner(board)	
	if won?(board)
		board[won?(board)[0]]
	end 
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
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



