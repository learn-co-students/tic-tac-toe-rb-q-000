require 'pry'
# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0,1,2], # Top Row
  [3,4,5], # Middle Row
  [6,7,8], # Bottom Row
  [0,3,6], # left vertical row
  [1,4,7], # middle vertical row
  [2,5,8], # right vertical row
  [0,4,8], # top left to bottom right row
  [2,4,6]  # bottom left to top right row
]

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


# code your move method here!
def move(board, position, player = current_player(board))
  board[position.to_i - 1] = player
end


# check to see if move during the turn was valid
def valid_move?(board,position)
  if (position_taken?(board, position.to_i - 1) == false) && (position.to_i.between?(1,9) == true)
  true
  else (position_taken?(board, position.to_i - 1) == true) || (position.to_i.between?(1,9) == false)
  false
  end
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input) == true
    puts "valid move"
    move(board, input)
    display_board(board)
  elsif valid_move?(board, input) == false
    puts "invalid move"
    turn(board)
  end
end


def turn_count(board)
  counter = 0
  board.each do |i|
    if (i == "X")
      counter += 1
    elsif (i == "O")
      counter += 1
    else
    end
  end
  return counter
end


def current_player(board)
  if turn_count(board).even?
    return "X"
  else 
    return "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_pos1 = combo[0]
    win_pos2 = combo[1]
    win_pos3 = combo[2]

    position1 = board[win_pos1]
    position2 = board[win_pos2]
    position3 = board[win_pos3]

    if (position1 == "X" && position2 == "X" && position3 == "X") || (position1 == "O" && position2 == "O" && position3 == "O")
      return combo
    end
  end
  return false
end


def full?(board) 
  board.all? { |i| i == "X" || i == "O" }
end


def draw?(board)
  full?(board) && !won?(board)
end


def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  end
end


def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end

end


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







