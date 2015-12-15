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

def move(board, position, token = "X")
  board[(position.to_i)-1] = token
end

def position_taken?(board, position)
  if board[position] == "X" || board[position] == "O"
    true
  elsif board[position] == " " || board[position] == ""
    false
  end
end


def valid_move?(board,position)
  true_position = board[(position.to_i)-1]
  if true_position != "X" && true_position != "O" && position.to_i.between?(1,9)
    return true
  else
    return false
  end
end


def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
    if valid_move?(board,position) == true
       then move(board,position, current_player(board))
       display_board(board)
       elsif  valid_move?(board,position) != true
          loop do
          puts "Sorry, please try a valid entry from 1-9:"
          position = gets.strip
          if valid_move?(board,position) == true
                  then move(board,position, current_player(board))
                  display_board(board)
              break
            end
        end
    end
end 


def turn_count(board)
  spaces = board.count(" ") 
  return 9 - spaces
end

def current_player(board)
    play = 0
  if turn_count(board) % 2 == 0
    play = "X"
  else turn_count(board) % 2 != 0
    play = "O"
  end
end

def full?(board)
    if board.each.detect{|i| i == " "} 
      false
    else board.each.detect{|i| i != " "} && won?(board) == false
      true
    end
end

def draw?(board)
    if  (full?(board) == true) && (won?(board) == false)
      true
    else (full?(board) == false) && (won?(board) == false)
  end
end

def over?(board)
    if won?(board) != false
      true
    elsif draw?(board) == false
    else full?(board) == true
  end
end

def winner(board)
  if draw?(board) == false
    i = won?(board)
    h = i[0]
    return board[h]
  else
  end
end

def play(board)
    while over?(board) == false
        turn(board)
        draw?(board) == true
      end
        if draw?(board) == true
           puts "Cats Game!"
        elsif won?(board) != false
            puts "Congratulations #{winner(board)}!"
        else
      end
    end




########################################################
############## 1 of 12 #################################

# def play(board)
#     while over?(board) == false
#         turn(board)
#       end
#         if draw?(board) == true
#            puts "Cats Game!"
#         elsif won?(board) != false
#             puts "Congratulations #{winner(board)}!"
#         else
#       end
#     end
########################################################
