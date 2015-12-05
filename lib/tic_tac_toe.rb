#This constant is a nested array which contains the winner combinations in tic tac toe
WIN_COMBINATIONS = [[0,1,2], #Top row winner
  [3,4,5], # Middle row winner
  [6,7,8], #Bottom row winner
  [0,3,6], #Left column winner
  [1,4,7], #Middle column winner
  [2,5,8], #Right column winner
  [0,4,8], #Diagonal left-to-rigth winner
  [2,4,6]  #Diagonal right-to-left winner
  ]

def play(board)
  until over?(board)
    turn(board)
  end
  puts "Congratulations #{winner(board)}!" if won?(board)
  puts "Cats Game!" if draw?(board)
end

#helper methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board)%2==0? "X" : "O"
end

def won?(board)
  win_combination = WIN_COMBINATIONS.find do |win_combination|
    win_combination.all? {|index| board[index]=="X"} or win_combination.all? {|index| board[index]=="O"}
  end
  if win_combination == nil
    return false
  else
    return win_combination
  end
end

def full?(board)
  board.all?{|space| space =="X" || space =="O"}
end

def draw?(board)
  return true if full?(board) && won?(board)==false
end

def over?(board)
  return true if won?(board)!=false||draw?(board)
end

def winner(board)
  if won?(board)!=false
    board[won?(board)[0]]
  end
end

