# code your move method here!
#1. Define methods
#DISPLAY_BOARD


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, position)
 position = position.to_i
  if position.between?(1,9) && !position_taken?(board, position -1) 
    true
  end
end

def position_taken?(board, position)
  position = position.to_i
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  elsif board[position] == "X" || board[position] == "O"
    true
  end
end

def move(board, position, player = "X")
  #position = position.to_i - 1
  board[(position.to_i)- 1] = player
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board,position)
    move(board, position, player = current_player(board))
    display_board(board)
  else
    puts "Please enter 1-9:"
    position = gets.strip
  end
end

def turn_count(board)
  
  count = 0
  board.each do |math|
    if math == "O" || math == "X"
    count += 1
  end
end
count
end

def current_player(board)
    if turn_count(board) % 2 == 0
     "X"
    else
     "O"
    end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS =[
  [0,1,2],[0,3,6],[1,4,7],[2,5,8],[3,4,5],[6,7,8],[0,4,8],[6,4,2]]
  
    #defines a constant WIN_COMBINATIONS with arrays for each win combination (FAILED - 1)

  
def won?(board)
  
WIN_COMBINATIONS.detect do |a|
    (a.all?{|position| board[position] == "X"}) || (a.all?{|position| board[position] == "O"})

end

end
 
def full?(board)
if board.any? {|bb| bb.strip.empty?}
false
else
true
end
end

def draw?(board)
if full?(board) && !won?(board)
  true
end
end

def over?(board)
 if full?(board) || draw?(board) || won?(board)
  true
end
end

def winner(board)
  whowin=won?(board)
if whowin
 board[whowin[0]]

end

end


def play(board)

  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end



#until the game is over
 # take turns
#end

#if the game was won
#  congratulate the winner
#else if the game was a draw
 # tell the players it has been a draw
#end