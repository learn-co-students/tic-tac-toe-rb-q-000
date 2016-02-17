#All possible ways to win the game
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

#displays the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#allows a player to make a move
def move(board, location, char='X')
  board[location-1] = char
end

#checks if a position is already filled
def position_taken?(board, array_location)
  if board[array_location] == 'X' || board[array_location] == 'O'
    return true
  else
    return false
  end
end

#check if user input is valid and that position is open
def valid_move?(board, location)
  if location.to_i < 1 || location.to_i > 9
    return false
  elsif position_taken?(board, location.to_i-1)
    return false
  else
    return true
  end
end

#algorithm to run a whole user's turn
def turn(board)
  puts "Enter a position (1-9):"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input.to_i, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

#returns number of turns
def turn_count(board)
  filled_positions = 0
  board.each do |position|
    if position == 'X' || position == 'O'
      filled_positions += 1
    end
  end
  return filled_positions
end

#determines whose turn it is
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

#determines if someone has won, returns an array of the winning combination
def won?(board)
  #iterate over each way to win
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    location1 = board[win_index_1]
    location2 = board[win_index_2]
    location3 = board[win_index_3]

    if location1 == 'X' && location2 == 'X' && location3 == 'X'
      return win_combination
    elsif location1 == 'O' && location2 == 'O' && location3 == 'O'
      return win_combination
    end
      
  end #end of each method
  #if no one has won return false
  return false
end #end of won? method

#determines if the board has all 9 spaces occupied
def full?(board)
  isFilled = 0
  board.each do |position|
    if position == 'X' || position == 'O'
      isFilled += 1
    end
  end
  return isFilled == 9
end

#determines if the game is a draw
def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  elsif won?(board) == true
    return false
  elsif full?(board) == false && won?(board) == false
    return false 
  end
end

#determines if game is over
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

#determines who the winner is
def winner(board)
  return won?(board) ? board[won?(board)[0]] : nil
end

#game logic
def play(board)
  if over?(board)
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cats Game!"
    end
  else
    turn(board)
    play(board)    
  end
end




