# Controls gameplay cycle
def play(board)
  while !over?(board)
    turn(board)
  end
  if(won?(board))
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end

# Helper Methods
# Returns number of turns that have passed
def turn_count(board)
  turns = 0;
  ![0,1,2,3,4,5,6,7,8].each do |pos|
    if position_taken?(board,pos)
      turns+=1;
    end
  end
  turns;
end
# Returns who the current player is
def current_player(board)
  if(turn_count(board)%2==0)
    "X"
  else
    "O"
  end
end
# Displays the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
# Places the current_player's token at their chosen location on the board
def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end
# Checks whether the specified position is taken
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end
# Checks whether the specified position is on the board and not taken
def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end
# Gets user input and places their token at the input location
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
# All the possible win combinations
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8], # All horizontal combinations
                    [0,3,6],[1,4,7],[2,5,8], # All vertical combinations
                    [0,4,8],[6,4,2]] # All diagonal combinations
# Checks whether anyone has won and returns the winning three positions
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if((board[combo[0]]==board[combo[1]]) && (board[combo[1]]==board[combo[2]]) && (position_taken?(board,combo[0])))
      return combo
    end
  end
  false
end
# Checks whether the board is full
def full?(board)
  ![0,1,2,3,4,5,6,7,8].any?{|pos| !position_taken?(board,pos)}
end
# Checks if there is a draw
def draw?(board)
  if(!won?(board) && full?(board))
    true
  else
    false
  end
end
# Checks if the game is over
def over?(board)
  if(draw?(board) || won?(board))
    true
  else
    false
  end
end
# Returns the winner
def winner(board)
  if(won?(board))
    return board[won?(board)[0]]
  else
    nil
  end
end