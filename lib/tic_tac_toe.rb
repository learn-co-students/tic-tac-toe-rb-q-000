
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

##DISPLAY BOARD
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

##MOVE
def move(board, input, player = "X")
  board[input.to_i-1] = player
end

##POSITION_TAKEN?
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

##VALID_MOVE
def valid_move?(board, position)
	position = position.to_i
   if position.between?(1,9) && (position_taken?(board, position-1) == false) 
    valid_move = true
   else 
   	valid_move = false
   end
 end

##TURN 
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
  	until valid_move?(board, input)
  	puts "Move is invalid"
    input = gets.strip
    end
  end
  display_board(board)
end

##TURN_COUNT
def turn_count(board)
	counter = 0
	board.each do |turn|
    if turn == "X" || turn == "O"
    counter += 1
    end
  end
 counter
end

##CURRENT_PLAYER
def current_player(board)
	turn_count(board) % 2 == 0 ? "X" : "O"
end

##PLAY
def play(board)
	until over?(board) == true 
		turn(board)
		end
	     if won?(board) 
		    puts "Congratulations #{winner(board)}"
	     elsif draw?(board)
		    puts "Cats Game!"
	     end
end


##WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #TOP ROW WIN
  [3,4,5], #MID ROW WIN
  [6,7,8], #BOT ROW WIN   #  0 | 1 | 2
  [0,3,6], #LEFT WIN      #  ---------
  [1,4,7], #MID WIN       #  3 | 4 | 5
  [2,5,8], #RIGHT WIN     #  ---------
  [0,4,8], #L2R WIN       #  6 | 7 | 8
  [2,4,6]  #R2L WIN

]

#WON METHOD
def won?(board)
 WIN_COMBINATIONS.detect do |sequence|
    board[sequence[0]] == board[sequence[1]] &&
    board[sequence[1]] == board[sequence[2]] &&
    position_taken?(board, sequence[0])
  end
end

#FULL METHOD
def full?(board)
   board.all? do |characters|
   characters == "X" || characters == "O"
  end 
end

#DRAW METHOD
def draw?(board)
    full?(board) && !won?(board)
end

#OVER METHOD
def over?(board)
	won?(board) == true || draw?(board) == true || full?(board) == true
end

#WINNER METHOD
def winner(board)
   if winning_sequence = won?(board)
      board[winning_sequence.first]
    end
end