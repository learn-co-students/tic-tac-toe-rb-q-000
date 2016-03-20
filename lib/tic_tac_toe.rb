# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #across top
  [3,4,5], #across mid
  [6,7,8], #across bottom
  [0,3,6], #left column
  [1,4,7], #middle column
  [2,5,8], #right column
  [0,4,8], #diagonal1
  [6,4,2], #diagonal2
]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board =[" "," "," "," "," "," "," "," "," "])
  print " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end

# Define move function
def move(board,pos,char="X")
  pos = pos.to_i
  board[pos-1] = char
end

# Position taken  
# return True/False
def position_taken?(board,position)
  if board[position] == " " or board[position] == ""
    return false
  elsif board[position] == nil
    return false
  elsif board[position] == "X" or board[position] == "O"
    return true
  end
end

# Valid Move?
# return True/False
def valid_move?(board,position)
  position = position.to_i #convert string to integer
  position = position-1 #translate position to array location

  if position >= 0 and position < 9 #check for legal position
    if board[position].strip.empty?
      return true
    elsif position_taken?(board,position)
      return false #position is occupied
    end
  else
    return false #illegal position
  end
end

# Turn
def turn(board)
  player = current_player(board)
  puts "Please enter 1-9:"
  position = gets
  if valid_move?(board,position)
    move(board,position,player)
    display_board(board)
  else
    turn(board)
  end
end

# Turn count
# return count size
def turn_count(board)
 count = board.select do |letter| letter == "X" || letter == "O" end
 return count.size
end 

#current_player
# return "X" or "O"
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X" #even turn count == X
  end 
  return "O" #odd turn count == O 
end

#won
#returns winning array, False, or Nil
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
      # x wins
      return combo
    end
    
    if board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
      # o wins
      return combo
    end
  end

  return false
end

#full?
#returns true/false
def full?(board)

  board.any? do | position |
    if position =="" || position ==" " || position ==nil
      return false
    end
  end

  board.all? do | position |
    if position !="" || position !=" "
      return true
    end
  end
end

#draw?
#returns true/false
def draw?(board)
  full?(board) && !won?(board)
end

#over?
#returns true/false
def over?(board)
  full?(board) || draw?(board) || won?(board)
end

#winner
def winner(board)

  if won?(board) == false
    return nil
  end

  if board[won?(board)[0]] == "X" 
    return "X"
  elsif board[won?(board)[0]] == "O"
    return "O"
  end
end

# Define your play method below
def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
