require 'pry'
WIN_COMBINATIONS = [
[0, 1, 2], 
[3, 4, 5],
[6, 7, 8], 
[0, 3, 6], 
[1, 4, 7], 
[2, 5, 8],
[0, 4, 8], 
[2, 4, 6]
]
def display_board(board)
   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
   puts " #{board[3]} | #{board[4]} | #{board[5]} "
   puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "
 end

 def move(board, location, player = "X")
   board[location.to_i-1] = player
end 

def position_taken?(board, position)
if board[position] == " " || board[position] == "" || board[position] == nil
  false
else board[position] == "X" || board[position] == "O"
true
  end
end

def valid_move?(board, position)
   position.to_i.between?(1,9) && !position_taken_1?(board, position)
end

def position_taken_1?(board, position)
  !(board[position.to_i-1] == " ")
end

def turn(board)
puts "Please enter 1-9:"
position = gets.strip
if valid_move?(board, position)
  move(board, position, current_player(board))
  display_board(board)
  else puts "Invalid Move!!"
    turn(board)  
  end
end

def turn_count(board)
  board.count{|item| item == "X" || item == "O"} 
  turns = 0
  board.each do |item|
    if item == "X" || item == "O"
  turns += 1
  end
end
turns 
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
     if board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X" ||
        board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O"
     return win_combo
     end
   end
  nil
end

def full?(board)
    board.all? do |filled|
    filled == "X" || filled == "O"   
    end
  end

  def draw?(board)
   full?(board) && !won?(board)
 end

   def over?(board)
  won?(board) || full?(board)
 end

 def winner(board)
  if win_com = won?(board)
  board[win_com[0]]
  end
end

def play(board)
   while !over?(board) && !draw?(board) 
   turn(board)
end
   if won?(board) 
   puts "Congratulations #{winner(board)}!"
   elsif draw?(board)
   puts "Cats Game!"
  end
end






