

#WIN_COMBINATIONS
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
  ]
#################### end of definition #WIN_COMBINATIONS



#display_board
#board = [" "," "," "," "," "," "," "," "," "]
def display_board(board) #Do NOT remove!

  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "

end
#################### end of method #display_board


#move

def move(board, position, current_player = "X")
  board[position.to_i-1] = current_player
end
#################### end of method #move


#position_taken?
def position_taken?(board, position)
  if board[position] == " " or board[position] == "" or board[position] == nil
    return false

  elsif board[position] == "X" or board[position] == "O"
    return true
end
position_taken? board, position
end
#################### end of method #position_taken?


#valid_move?
def valid_move?(board, position)
  position = position.to_i - 1
  if board[position] == "X"
    return false

  elsif position == "O"
    return false

  elsif position == " " or position == "" or position == nil
    return true

  elsif position.between?(0, 8)
    return true
  end
end
#################### end of method #valid_move?



#turn
def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip

  if valid_move?(board, position) #&& position_taken?(board, position)
    move(board, position, current_player = "X")
    puts "Please enter 1-9 again:"
  else
    puts "Please enter a valid number"
    turn(board)
  end

  display_board(board)

end
####
# def display_board(board)
#removed
####
def valid_move?(board, position)
  position = position.to_i
  position.between?(1, 9) && !position_taken?(board, position)
end

####
def position_taken?(board, position)
  board[position.to_i-1] == "X" or board[position.to_i-1] == "O"
end

####
def move(board, position, current_player = "X")
  board[position.to_i-1] = current_player
end
#################### end of method #turn



#play--#from ttt-9-play-loop  #may need to re-define #play(board)
# def display_board(board)
#removed

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

# def turn(board)
#   puts "Please enter 1-9:"
#   input = gets.strip
#   if valid_move?(board, input)
#     move(board, input)
#   else
#     turn(board)
#   end
#   display_board(board)
# end


#### fr Kyle ####
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    player = current_player(board)
    move(board, input, player)
  else
    turn(board)
  end

  display_board(board)
end
###### above fr Kyle

####
# Define your play method below
# #play method was originally at this position
# def play(board)
#   round = 0
#   while round <9
#     turn(board)
#     round += 1
#   end
# end
#################### end of method #play--#from ttt-9-play-loop



#current_player
def turn_count(board)
  x_counter = 0
  o_counter = 0
  board.each do |spot|

    if spot == "X"
      x_counter += 1

    elsif spot == "O"
      o_counter += 1
    end
  end

return x_counter + o_counter
end

def current_player(board)
    if turn_count(board) % 2 == 0
        return "X"
    else
        return "O"
    end
end
#################### end of method #current_player



#Tic Tac Toe game_status
def position_taken?(board, position)
  !(board[position].nil? || board[position] == " ")
end


# WIN_COMBINATIONS = [
#removed

def won?(board)

WIN_COMBINATIONS.find do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end
#full
def full?(board)
  board.each do |cell|
    cell != " " or cell != "nil"
    if cell == " " or cell == "nil"
      return false
    end
  end
end
#draw
def draw?(board)
  full?(board) && !won?(board)
end
#over
def over?(board)
  draw?(board) && full?(board) or won?(board)
end

def winner(board)
  if won?(board)
    winner_array = won?(board)
    board[winner_array[0]]
  else
    return nil
  end
end
#################### end of method #Tic Tac Toe game_status

#play  #tic_tac_toe.rb coding starts here
def play(board)
  puts "Please enter 1-9: "
  round = 0
  until over?(board) or round >9 or draw?(board)
    turn(board)
    round += 1
  end

  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
