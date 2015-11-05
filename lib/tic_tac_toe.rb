
WIN_COMBINATIONS = [
 [0,1,2], [3,4,5], [6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

 
 def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} " 
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} " 
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} " 
end

def move(board, position, char="X")
  board[position.to_i - 1]= char
  display_board(board)
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board,position) 
  position = position.to_i
  position.between?(1,9) && position_taken?(board,position-1) == false
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board,position)
    move(board,position,current_player(board))

  else
    turn(board)
  end
end

def turn_count(board)
    tc=0
    counter=0
    while counter<= board.length-1
    if position_taken?(board, counter)
       tc +=1
    end
    counter+=1
  end
  tc
end

def current_player(board)
  if turn_count(board).even?
      "X"
   else
    "O"
  end
end

def won?(board) 
  WIN_COMBINATIONS.detect do |combo|
   board[combo[0]] == board[combo[1]] &&
   board[combo[1]] == board[combo[2]] &&
   position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  full?(board) && !won?(board)   
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if winning_combo = won?(board)
    puts "Congratulations #{board[winning_combo.first]}!"
    board[winning_combo.first]
  else
    puts "Cats Game!"
  end

end

def play(board)
  
  until over?(board) || draw?(board)
    turn(board)
end
winner(board)

end