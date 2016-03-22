WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], #Bottom row

  [0,3,6], #Left column
  [1,4,7], #Middle Column
  [2,5,8], #Right column

  [2,4,6], #diagonal one
  [0,4,8] #diagonal two
]

def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "

end

def move(board, input, xoro = "X")
location = input.to_i - 1
board[location] = xoro
end

def valid_move?(board, position)

if position_taken?(board, index = position.to_i - 1) == true
   false
elsif (0..8).cover?(index) == true
  return true
end
end


# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, position)
  location = position.to_i
  if board[location] == " "
    false
   elsif board[location] == ""
    false
   elsif board[location] == nil
    false
    else
    true
  end
end

def turn(board)
puts "Please enter 1-9:"
position = gets.strip
  if valid_move?(board, position) == true
    move(board, position, xoro = current_player(board))
    display_board(board)
  else
  turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |x|
    if x == "X" || x == "O"
      turns +=1
    end
  end
  turns
end

def current_player(board)
if turn_count(board) % 2 == 0
 "X"
  else
 "O"
end
end

def won?(board)

WIN_COMBINATIONS.each do |winarray|
  win_index_1 = winarray[0]
  win_index_2 = winarray[1]
  win_index_3 = winarray[2]

  position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]

  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return winarray # return the win_combination indexes that won.
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return winarray

  end
end
false
end

def full?(board)
if board.detect{|i| i == " "}; false; else; true; end
end

def draw?(board)
if board.detect{|i| i != " "} && won?(board) == false; true;
  elsif won?(board) == true; false;
  elsif board.detect{|i| i == " "}; false;
end
end


def over?(board)
if full?(board) == false; return false; end
 if draw?(board) == true; true;
    elsif won?(board) != false; true;
    end
end


def winner(board)
if draw?(board) == true; nil;
  else

  WIN_COMBINATIONS.each do |winarray|
  win_index_1 = winarray[0]
  win_index_2 = winarray[1]
  win_index_3 = winarray[2]

  position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]

  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    winner = "X"
    return winner
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    winner = "O"
    return winner
  else
    false
  end
end
false
end
end

def play(board)

until over?(board) == true
  turn(board)
end

  if won?(board) == true
    puts "Congratulations #{winner(board)}!"

  elsif draw?(board) == true
    puts "Cats Game!"
 end

end
#until the game is over
#  take turns
#end

#if the game was won
#  congratulate the winner
#else if the game was a draw
#  tell the players it has been a draw
#end




