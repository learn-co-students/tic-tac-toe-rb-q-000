
board = [ " ", " ", " ", " ", " ", " ", " ", " ", " "]

WIN_COMBINATIONS = [
[0,1,2], #top row
[3,4,5], #middle row
[6,7,8], #bottom row
[0,3,6], #left column
[1,4,7], #middle column
[2,5,8], #right column
[0,4,8], #left to right diagonal
[2,4,6], #right to left diagonal
]

def display_board(board)
     puts " #{board[0]} | #{board[1]} | #{board[2]} "
     puts "-----------"
     puts " #{board[3]} | #{board[4]} | #{board[5]} "
     puts "-----------"
     puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def move(board, position, character= "X")
  position.to_i
  board[position.to_i - 1] = character
  end

  def position_taken?(board, position)
 if board[position] == " "
 return false
    elsif board[position] == ""
 return false
    elsif board[position] == nil
  return false
    elsif board[position] == "X" || "O"
  return true
  end
end

#valid move
def valid_move?(board, position)
  position = position.to_i
  if position.between?(1, 9) &&
  !position_taken?(board, position - 1) 
  return true 
  else return false 
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets
  position.chomp
  if valid_move?(board, position)
    return move(board, position, current_player(board)) && display_board(board)  
  else return turn(board)
  end 
end

#turn_count
  def turn_count(board)
  counter = 0
  board.each do |board|
    if board == "X" || board == "O"
     counter += 1
   end
  end
  return counter
end


def current_player(board)
  if turn_count(board) % 2 == 0
     return "X"
   else return "O"
   end
end


def won?(board)
WIN_COMBINATIONS.detect do |win_combination|
  position_taken?(board, win_combination[0]) && board[win_combination[0]] == 
    board[win_combination[1]] && board[win_combination[1]] == 
      board[win_combination[2]]
  end
end 

def full?(board)
  board.all? do |board|
   position_taken?(board, board)
   end  
end


def draw?(board)
  if full?(board) == true && !won?(board) == true
    return true
  else return false
  end
end

def over?(board)
  if draw?(board) == true || !won?(board) == false
  return true
  else return false
  end
end 

def winner(board)
  #return who won- X or O/ return string x or o
  if win_array = won?(board) 
    return board[win_array[0]]
    else return nil
  end
end

def play(board)
  while over?(board) == false
    turn(board)
  end
  if !won?(board) == false
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cats Game!"
  else return nil
  end
end
  
 
#if the game was won
  #congratulate the winner
#else if the game was a draw
  #tell the players it has been a draw
#end
  #input = gets
      


