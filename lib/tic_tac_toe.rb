WIN_COMBINATIONS = [
   [0,1,2],
   [3,4,5],
   [6,7,8],
   [0,3,6],
   [1,4,7],
   [2,5,8],
   [0,4,8],
   [6,4,2]
    ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end



def move(board, position, char=  "X")
  board[position.to_i - 1] = char.upcase
end

def turn(board)
  display_board(board)
puts "Please enter 1-9:"
  user_input = gets.strip
  valid = valid_move?(board, user_input)
  if !valid
    display_board(board)
  puts "That was invalid.  Please enter 1-9"
  user_response = gets.strip
  end
  current_char = current_player(board)
  current_move = move(board, user_input, current_char)
display_board(board)
end

def position_taken?(board, position)
  if !(board[position.to_i].nil?) && (board[position] == "X" || board[position] == "O")
    true
  else
    false
  end
end

def valid_move?(board, position)
  if position.to_i.between?(1,9)
    if !position_taken?(board, position.to_i-1)
      true
    end
  end
end

def position_taken?(board, position)
  board[position] != " "
end

def valid_move?(board, position)
  if position.to_i.between?(1,9)
    if !position_taken?(board, position.to_i-1)
      true
    end
  end
end

def turn_count(board)
  counter = 0
  board.each do |string|
    if string == "X" || string == "O"
      counter +=1
    end
  end
  counter
end

def current_player(board)
  whos_move = turn_count(board)
  whos_move.odd? ? "O" : "X"
end

def won?(board)
WIN_COMBINATIONS.each do |index|
  return index if index.all? {|position| board[position] == "X" }
  return index if index.all? {|position| board[position] == "O" }
end
false
end


def full?(board)
  !board.include?(" ")
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  (won?(board) || draw?(board)) ? true : false
end

def winner(board)
  WIN_COMBINATIONS.each do |index|
  return "X" if index.all? {|position| board[position] == "X" }
  return "O" if index.all? {|position| board[position] == "O" }
end
nil
end

def play(board)

until over?(board) == true
current_player(board)
turn(board)
end
if draw?(board)
  puts "Cats Game!"
elsif winner(board)
puts "Congratulations #{winner(board)}!"
end
end


