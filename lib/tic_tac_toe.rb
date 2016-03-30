require 'pry'
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

def position_taken?(board, location)
  !(board[location.to_i].nil? || board[location.to_i] == " ")
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end


def valid_move?(board, position)
  if position.to_i.between?(1,9) and !position_taken?(board, position.to_i-1)
    return true
  else
    return false
end
end


def turn(board)
  puts "Please enter 1-9:"
  input= gets.chomp.to_i
  current_player= current_player(board)
  if valid_move?(board, input)
    move(board, input, current_player)
    display_board(board)
else
  turn(board)
end
end

def turn_count(board)
  counter=0
  board.each do |i|
     counter+=1 if i == "X" or i == "O"
    end
    return counter
  end

def current_player(board)
   if turn_count(board)%2== 0
  return "X"
else
  return "O"
end
end


def won?(board) 
WIN_COMBINATIONS.detect do |combination|
combination.all?{|player| board[player] == "X"} or combination.all?{|player| board[player] == "O"} 
end 
end

def full?(board)
  board.all?{|token| token!= " "}
end

def draw?(board)
   !won?(board) and full?(board)
end

def over?(board)
  won?(board) or draw?(board)
end

def winner(board)
if winnertoken= won?(board)
  return board[winnertoken.first]
end
end

def play(board)
until over?(board)
turn(board)
end
finalwin= winner(board)
if draw?(board)
  puts "Cats Game!"
elsif puts "Congratulations #{finalwin}!"
end
end
