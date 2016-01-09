board = [" "," "," "," "," "," "," "," "," "]

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
  input = gets.strip
  if valid_move?(board, input)
    move(board, input,current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count (board)
  count = 0
  board.each do |x|
   if x != " "
     count += 1
   end
  end
  return count
end

def current_player(board)
#   if turn_count(board) % 2 == 0
#     return "X"
#   else
#     return "O"
#   end
  turn_count(board) % 2 == 0 ? "X" : "O"
end



WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

def won?(board)
  WIN_COMBINATIONS.each do |wincombo|
    winningcombo = [board[wincombo[0]],board[wincombo[1]],board[wincombo[2]]]
    xcombo = winningcombo.all? {|position| position == "X"} #are X's in all the winning combo places?
    ocombo = winningcombo.all? {|position| position == "O"}
    return wincombo if xcombo || ocombo
  end #each_end
  false
end #method_end

#     wincombo1 = wincombo[0] #the index of a winning position
#     wincombo2 = wincombo[1]
#     wincombo3 = wincombo[2]
#     position1 = board[wincombo1] #the move "X" or "O" or " "
#     position2 = board[wincombo2]
#     position3 = board[wincombo3]
#     if position1 == "X" && position2 == "X" && position3 == "X"
#       return wincombo
#     elsif position1 == "O" && position2 == "O" && position3 == "O"
#       return wincombo
#     else
#       return false
#     end #if_end


def full?(board)
  if board.any? {|x| x == " "}
    return false
  else
    return true
  end
end

def draw?(board)
  if won?(board) || !full?(board)
    false
  else
    true
  end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
  wincombo = won?(board) #original winning array
  if wincombo
    return board[wincombo[0]]
  end
end

def play (board)
  while over?(board) != true
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end #end_play

