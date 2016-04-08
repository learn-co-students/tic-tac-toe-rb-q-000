# Helper Methods

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = "X")

  board[location.to_i-1] = current_player(board)
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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def play(board)
  counter = 1
  until counter == 10
    if won?(board) 
      puts "Congratulations #{winner(board)}!"
      break
    elsif draw?(board)
      puts "Cats Game!"
      break
    elsif over?(board)
      break
    else
    turn(board)
    counter+=1
    end
  end
end




def turn_count(board)
  counter = 0
  board.each do |space|
    if (space == "X" || space == "O")
      counter+= 1
    end
  end
  return counter
end


def current_player(board)
  if turn_count(board).odd? 
    return "O"
  else
    return "X"
  end
end


# Helper Method


def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
[0,1,2], #top row
[3,4,5], #middle
[6,7,8], #bottom
[0,4,8], #left diagonal
[2,4,6], #right diagonal
[0,3,6], #1st column
[1,4,7], #2nd column
[2,5,8] #3rd column
]

def won?(board)
  WIN_COMBINATIONS.detect do |i|
    board[i[0]] == board[i[1]] && board[i[1]] == board[i[2]] && position_taken?(board, i[0])
  end
end


def full?(board)
  board.all? {|token| token == "X" || token == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  if !won?(board)
    return nil
  else
    return board[won?(board)[0]]
  end
end







