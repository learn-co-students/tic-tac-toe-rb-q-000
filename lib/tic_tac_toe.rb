WIN_COMBINATIONS = [
    [0,1,2], 
    [3,4,5],
    [6,7,8], 
    [0,3,6], 
    [1,4,7], 
    [2,5,8],
    [2,4,6],
    [0,4,8]
]

def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, value = "X")
  board[position.to_i-1] = value
end

def position_taken?(board, position)
  (board[position] == " " || board[position] == "") ? false : true
end

def valid_move?(board, position)
  answer = false

  if position.to_i.between?(1, 9) && position_taken?(board, position.to_i-1) == false
    answer = true
  else
   answer = false
  end
  answer
end

def turn(board)
  puts "Please enter 1-9:"

  input = gets.strip 
  if valid_move?(board,input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |x|
    if x == "O" || x == "X"
      counter +=1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).even?
     "X"
  else
     "O"
  end
end

def won?(board)

  WIN_COMBINATIONS.find do |combo|
    #I realized since each index has to be the same value (either all "X" or all "O") for it to be a winning combination, 
    #set them equal to eachother instead of writing out the each of the three index separately equal to "X" (or "O")
    #i'd have to write that out 6 six times! 
     board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]] && position_taken?(board, combo[0]) 
  end
end

def full?(board)
  board.all? do |value|
    value == "X" || value == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
end
    
def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  win_index = won?(board)

  if won?(board)
    board[win_index[0]]
  else
    nil
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
