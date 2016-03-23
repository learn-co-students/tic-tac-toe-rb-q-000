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
board[input.to_i - 1] = xoro
end

def valid_move?(board, position)
if position_taken?(board, index = position.to_i - 1) == true
   false
elsif (0..8).cover?(index) == true
  return true
end
end

def position_taken?(board, position)
 !(board[position].nil? || board[position] == " ")
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
 board.count do |turn| turn == "X" || turn == "O"
 end
end

def current_player(board)
if turn_count(board) % 2 == 0
 "X"
  else
 "O"
end
end

def won?(board)
WIN_COMBINATIONS.collect do |winarray|
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
board.all?{|i| i == "X" || i == "O"}
end

def draw?(board)
won?(board) == false && full?(board)
end

def over?(board)
if won?(board) == false && draw?(board) == false
  false
  else
  true
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
    nil
  end
end
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

#until the game is over
#  take turns
#end

#if the game was won
#  congratulate the winner
#else if the game was a draw
#  tell the players it has been a draw
#end




