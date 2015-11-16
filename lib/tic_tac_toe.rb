WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]


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



def position_taken?(board,position)
  if board[position]=="" || board[position] ==" " || board[position] == nil
    return false
  elsif board[position] == "X" || board[position] == "O"
    return true
  end
end

def valid_move?(board, position)
  if position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
    true
  end
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
  board.each do |move|
    if move == "X" || move == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).odd? 
    return "O"
  else
    return "X"
  end
end 


def won?(board)

  WIN_COMBINATIONS.detect do |win_combinations|
    board[win_combinations[0]] == board[win_combinations[1]] &&
    board[win_combinations[1]] == board[win_combinations[2]] &&   
    position_taken?(board, win_combinations[0]) 
  end
end

def full?(board)
  board.all?{|move| move == "X" || move == "O"}
end

def draw?(board)
full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if !won?(board)
    return nil
  else
    return board[won?(board)[0]] 
  end
end


def play(board)
  while !over?(board) && !draw?(board) && !won?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end






