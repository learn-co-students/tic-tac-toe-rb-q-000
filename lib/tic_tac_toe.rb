# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS =[
  [0,1,2], #Top Row
  [3,4,5], #Middle Row
  [6,7,8], #Bottom Row
  [0,3,6], #Left Column
  [1,4,7], #Middle Column
  [2,5,8], #Right COlumn
  [0,4,8], #Left Diagonal
  [2,4,6] #Right Diagonal
]

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
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  location = gets.strip
  if valid_move?(board, location)
    current_player = current_player(board)
    move(board, location, current_player)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)

counter = 0

board.each do |i|
  if i == "X" || i == "O"
   counter += 1
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

# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def won?(board)

  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      false
    end
  end
end

def full?(board)
  if board.detect{|x| x == "" || x == " "}
    false
  else
    true
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  win_combo = won?(board)
  if won?(board)
    return board[win_combo[0]]
  end
end


# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end
end






