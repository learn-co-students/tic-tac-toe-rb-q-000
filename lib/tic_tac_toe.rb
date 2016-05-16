def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move (board, position, char)
  board[position.to_i - 1] = char
end



def valid_move? (board,position)
return false if position_taken?(board, position.to_i - 1) ||  (position.to_i.between?(1,9)) == false
true
end


def turn(board)
 puts "Please enter 1-9:"
 input=gets.strip

  if valid_move?(board,input)
    move(board,input,current_player(board))
    display_board(board)
  else
    puts "invalid"
    turn(board)
  end

end

def turn_count(board)
count=0
  board.each{|place| count+=1 if place == "X" || place== "O"}
count
end

def current_player(board)
   (turn_count(board).even?) ?  "X" :  "O"
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
  end

def won?(board)
  xpos=[]
  opos=[]
  board.each_with_index do |position,index|
         xpos<<index if position=="X"
         opos<<index if position=="O"
  end
  WIN_COMBINATIONS.detect {|w| (w-xpos).empty? || (w-opos).empty? }
 end

def full?(board)
board.all?{|position| position=="X" || position=="O" }
end


def draw?(board)
  !won?(board) && full?(board)
end


def over?(board)
full?(board) ||  won?(board) || full?(board)
end

def winner(board)
  if combo=won?(board)
  return board[combo[0]]
  else
    nil
  end
end

def play (board)
  while !over?(board)
  turn(board)
  break if draw?(board)
  end
  (winner(board) != nil ) ? (puts "Congratulations #{winner(board)}!"): (puts "Cats Game!")

end
# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS=[
   [0,1,2], # Top row
   [3,4,5],  # Middle row
   [6,7,8], # Bottom row
   [0,3,6], # First column
   [1,4,7], # Second column
   [2,5,8], # Third  column
   [0,4,8], # Top left to bottom right diagonal
   [2,4,6] # Top right to bottom left diagonal
  ]
