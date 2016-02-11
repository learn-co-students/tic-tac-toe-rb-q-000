def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your move method here!
def move(board,position,character = "X")
  board[position.to_i-1] = character
end






def valid_move?(board,position)
  if  position.to_i.between?(1,9) && !position_taken?(board, position.to_i - 1)
    true
  else
    false
  end
end


def position_taken?(board,position)
  if board[position] == " "
    false
    elsif board[position] == ""
    false
    elsif  board[position] == nil
    false
    else   board[position] == "X" || board[position] == "O"
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




# Define your play method below
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



def turn_count(board)
  counter = 0
  board.each do |spot| 
    if spot == "X" || spot == "O"
      counter += 1 
    else
      nil
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 ==0
    return "X"
  else 
    return "O"
  end
end




WIN_COMBINATIONS = [
[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]

  p1 = board[win_index_1] # load the value of the board at win_index_1
  p2 = board[win_index_2] # load the value of the board at win_index_2
  p3 = board[win_index_3] # load the value of the board at win_index_3

    if (p1 == "X" && p2 == "X" && p3 == "X") || (p1 == "O" && p2 == "O" && p3 == "O")
      return win_combination # return the win_combination indexes that won.
  end
end
  return false
end


def full?(board)
board.all? do |space|
  space == "X" || space == "O"
  end
end


def draw?(board)
  if !won?(board) && full?(board)
    true
  end
end

def over?(board)
  if won?(board) || draw?(board)
    true
  else 
    false
  end
end


def winner(board)
  win = won?(board)  
    return board[win[0]] if win
end
