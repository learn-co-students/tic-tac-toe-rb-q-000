WIN_COMBINATIONS = [
[0,1,2], # 1st row
[3,4,5], # 2nd row
[6,7,8], # 3rd row
[0,4,8], # Diagonal
[6,4,2], # Diagonal
[0,3,6], # 1st column
[1,4,7], # 2nd column
[2,5,8]  # 3rd column
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, char="X")
  board[location.to_i-1] = char
end

def position_taken?(board, location)
  !(board[location] == " " || board[location] == "" || board[location] == nil)  #board[location] is not eq. to " " or "" or nil
end

def valid_move?(board, location)
  location.to_i.between?(1,9) && !position_taken?(board, location.to_i - 1)
end

def turn(board)
  puts "Please enter 1-9:"
  location = gets.strip
  while valid_move?(board, location) != true
     puts "Please enter 1-9:"
     location = gets.strip
  end
  move(board, location, current_player(board))
  display_board(board)
end

def turn_count(board)
 counter = 0
 board.each do |turn|
   if turn == "X"
     counter += 1
   elsif turn == "O"
       counter += 1
   else turn == " "
       counter += 0
     end
   end
   counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  result = false
  WIN_COMBINATIONS.each do |win_combination|
    if !result
      if win_combination.all?{|i| board[i]=="X"} || win_combination.all?{|i| board[i]=="O"}
         result = win_combination
      end
    end
  end
   result
end

def full?(board)
  if board.any?{|location| location == " "}
     false
    else
      true
    end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  else
   false
  end
end

def over?(board)
  if won?(board) == false && draw?(board) == false && full?(board) == false
    false
  else
    true
  end
end

def winner(board)
  win_combination = won?(board)
    if win_combination
      board[win_combination[0]]
    else
      nil
    end
end

def play(board)

  while !over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cats Game!"
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end
