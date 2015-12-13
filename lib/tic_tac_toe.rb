WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[6,4,2],[0,4,8],]
# match  positions:  1,2,3   4,5,6   7,8,9   1,4,7   2,5,8   3,6,9   7,5,3   1,5,9
def won?(board)
win_combination = WIN_COMBINATIONS

  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]
  win_index_4 = win_combination[3]
  win_index_5 = win_combination[4]
  win_index_6 = win_combination[5]
  win_index_7 = win_combination[6]
  win_index_8 = win_combination[7]

  position_1 = board[0] # load the value of the board at win_index_1
  position_2 = board[1] # load the value of the board at win_index_2
  position_3 = board[2] # load the value of the board at win_index_3
  position_4 = board[3] # load the value of the board at win_index_4
  position_5 = board[4] # load the value of the board at win_index_5
  position_6 = board[5] # load the value of the board at win_index_6
  position_7 = board[6] # load the value of the board at win_index_7
  position_8 = board[7] # load the value of the board at win_index_8
  position_9 = board[8] # load the value of the board at win_index_9

  if    position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combination[0] # return the win_combination indexes that won.
  elsif position_4 == "X" && position_5 == "X" && position_6 == "X"
    return win_combination[1] # return the win_combination indexes that won.
  elsif position_7 == "X" && position_8 == "X" && position_9 == "X"
    return win_combination[2] # return the win_combination indexes that won.
  elsif position_1 == "X" && position_4 == "X" && position_7 == "X"
    return win_combination[3] # return the win_combination indexes that won.
  elsif position_2 == "X" && position_5 == "X" && position_8 == "X"
    return win_combination[4] # return the win_combination indexes that won.
  elsif position_3 == "X" && position_6 == "X" && position_9 == "X"
    return win_combination[5] # return the win_combination indexes that won.
  elsif position_7 == "X" && position_5 == "X" && position_3 == "X"
    return win_combination[6] # return the win_combination indexes that won.
  elsif position_1 == "X" && position_5 == "X" && position_9 == "X"
    return win_combination[7] # return the win_combination indexes that won.
  
  elsif    position_1 == "O" && position_2 == "O" && position_3 == "O"
    return win_combination[0] # return the win_combination indexes that won.
  elsif position_4 == "O" && position_5 == "O" && position_6 == "O"
    return win_combination[1] # return the win_combination indexes that won.
  elsif position_7 == "O" && position_8 == "O" && position_9 == "O"
    return win_combination[2] # return the win_combination indexes that won.
  elsif position_1 == "O" && position_4 == "O" && position_7 == "O"
    return win_combination[3] # return the win_combination indexes that won.
  elsif position_2 == "O" && position_5 == "O" && position_8 == "O"
    return win_combination[4] # return the win_combination indexes that won.
  elsif position_3 == "O" && position_6 == "O" && position_9 == "O"
    return win_combination[5] # return the win_combination indexes that won.
  elsif position_7 == "O" && position_5 == "O" && position_3 == "O"
    return win_combination[6] # return the win_combination indexes that won.
  elsif position_1 == "O" && position_5 == "O" && position_9 == "O"
    return win_combination[7] # return the win_combination indexes that won.
  else
    false
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, value = "X")
  board[(position.to_i)-1] = value
end

def position_taken?(board, position)
  if board[position] == "X" || board[position] == "O"
    true
  elsif board[position] == " " || board[position] == ""
    false
  end
end


# #valid_move?

# Build a method valid_move? that accepts a board and a position to check and returns true if 
# the move is valid and false or nil if not. A valid move means that the submitted position is:

# Present on the game board.
# Not already filled with a token.

def valid_move?(board,position)
  if (position_taken?(board, position.to_i) == false) && ([position.to_i]-1).between?(1,9) == true)
    true
  elsif (position_taken?(board, position) == true)
    false
  elsif (position.to_i.between?(1,9) != true)  
    false
  else
  end
end
# def valid_move?(board, position)  
#   if position_taken?(board,position) == false && [position.to_i].between?(1, 9) == true
#     return true
#   else  
#     return false
#   end
# end


