WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [6,4,2],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def display_board(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def move(board, location, current_player = "X")
 board[location.to_i - 1] = current_player
end

def position_taken?(board, position)
 if board[position] == " " || board[position] == "" || board[position] == nil
   false
 elsif board[position] == "X" || "O"
   true
 end
end

def valid_move?(board, position)
 position = position.to_i
 if position.between?(1,9) && !position_taken?(board,position.to_i - 1)
   true
 else
   false
 end
end

def turn(board)
 loop do
   puts "Please enter 1-9:"
   position = gets.chomp
     if valid_move?(board, position)
       move(board, position, current_player(board))
       break
     end
 end
 display_board(board)
end

def turn_count(board)
 counter = 0
 board.each do |position|
   if position == "X" || position == "O"
     counter += 1
   end
 end
 return counter
end

def current_player(board)
 if turn_count(board) % 2 == 0
   return "X"
 else
   return "O"
 end
end

def won?(board)
 WIN_COMBINATIONS.detect do |win_combo|
   win_combo.all? { |position| board[position] == "X" } || win_combo.all? { |position| board[position] == "O" }
   end
end

def full?(board)
 unless board.any? {|pos| pos == " " || nil }
   board.all? == "X" || "O"
 end
end

def draw?(board)
 if full?(board) && !won?(board)
   true
 else
   false
 end
end

def over?(board)
 if won?(board) || draw?(board) || full?(board)
   true
 else
   false
 end
end

def winner(board)
 winning_player = won?(board)

if !winning_player
   return nil
 end

 winning_player.each do |i| 
   if board[i] == "X"
     return "X"
   elsif board[i] == "O"
     return "O"
   end
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





