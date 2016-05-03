#  rspec spec/01_tic_tac_toe_spec.rb


WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # bottom row
  [0,3,6],  # left column
  [1,4,7],  # Middle column
  [2,5,8],  # right column
  [0,4,8],  # lt to rt cross
  [2,4,6]  # rt to lt
]

#DISPLAY_BOARD
def display_board(board)
   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
   puts " #{board[3]} | #{board[4]} | #{board[5]} "
   puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#MOVE
def move(board, position, character) #used to be def move(board, position, character = "X")
  board[position.to_i - 1] = character
end

#position_taken
def position_taken?(board, position)
   if board[position] == " "|| board[position] == "" || board[position] == nil
    false
   elsif board[position] == "X" || board[position] == "O"
    true
  end
end

#Valid_move
def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

#TURN
def turn(board)              #get input
  puts "Please enter 1-9:"  #asks user for input
  input = gets               #gets input
  if valid_move?(board,input) #validate the move #used to be if valid_move?(board,input)
    move(board, input, current_player(board))
    else
    puts "Please enter 1-9:"  #asks user for input
    input = gets
  end
  display_board(board)
end

#TURN_COUNT
def turn_count(board)  #defines the #turn_count method
  counter = 0  #sets counter or count of turns to 0
  board.each do |position| #implementing iterator #each to loop over the elements of the board array
    if position == "X" || position == "O"
      counter += 1
    end
  end
  counter
end

#CURRENT_PLAYER
def current_player(board)

  if turn_count(board).odd?
    "O"
    else turn_count(board).even?
    "X"
  end
end

#WONwin
def won?(board)
  WIN_COMBINATIONS.each do| position |
    if board[position[0]] == "X" && board[position[1]] == "X" && board[position[2]] == "X" || board[position[0]] == "O" && board[position[1]] == "O" && board[position[2]] == "O"
      return position
    end
  end
  false
end

#FULL
def full?(board)
  board.all? {|position| position == "X" || position == "O"} #all board is full with x or o
 # return true if every element in the board contains either an "X" or an "O"
end

#DRAW
def draw?(board)
  if !won?(board) && full?(board)
    true
   else
      false
  end
end

#OVER
def over?(board)
  if full?(board) || won?(board) || draw?(board)
    true
  end
end

#WINNER
def winner(board)
  if won?(board) == false
    nil
  else board[won?(board)[0]]
  end
end

#Play


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
