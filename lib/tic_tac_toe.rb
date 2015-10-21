#Display board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Gameplay
#Put marker on board
def move(board, location, player = "X")
  board[location.to_i-1] = player
end

#Validate move
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

#Define a turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  player = current_player(board)
  if valid_move?(board, input)
    move(board, input, player)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do | turn |
    if turn == "X" || turn == "O"
      counter += 1
    end
  end
  return counter
end

#Determine current player
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end



#Determine game status
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

def won?(board)
  WIN_COMBINATIONS.detect do |winning_combination|
    (winning_combination.all?{|position| board[position] == "X"}) || (winning_combination.all?{|position| board[position] == "O"})
  end
end

def full?(board)
  !(board.include?(" ") || board.include?(nil) || board.include?(""))
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    winning_array = won?(board)
    return board[winning_array[1]] 
  else
    return nil
  end
end

#Play loop
def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end