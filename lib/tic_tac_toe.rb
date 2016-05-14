# We'll be representing a Tic Tac Toe board using an array of " " strings. 
# We'll pass this board to every method as an argument so the helper methods can interact with or introspect on the board.
# We'll be getting user input via gets and a player will choose a position by entering 1-9. 
# Our program will then fill out the appropriate position on the board with the player's token.
# We will keep track of which player's turn it is and how many turns have been played. 
# We will check to see, at every turn, if there is a winner. If there is a winner, we'll congratulate them. 
# If there is a tie, we will inform our players.


# identifying the different win index-value combinations for tic-tac-toe
WIN_COMBINATIONS = [
[ 0, 1, 2],
[ 3, 4, 5],
[ 6, 7, 8],
[ 0, 3, 6],
[ 1, 4, 7],
[ 2, 5, 8],
[ 0, 4, 8],
[ 2, 4, 6],
]

# the 9 empty spaces of the tic-tac-toe board
board = [" "," "," "," "," "," "," "," "," "]

# prints the current board representation based on the board argument pased to the method
def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# make a move
def move(board, input, n = "X")
    # if the move is valid and the move is either an "X" or "O" 
    # then move to the position that is the input number - 1 for array index
    # and enter either an "X" or "O" in the spot
    # or else the move is invalid
    if valid_move?(board, input) && (n == "X" || n == "O")
        return board[input.to_i - 1] = n
    else
        return false
    end
end

# evaluating input against the board and checking to see
# whether or not that position is occupied 
def position_taken?(board, position)
    # if position on the board is empty, or nil then the board is not taken
    if board[position] == "" || board[position] == " " || board[position] == nil
        return false
    # else if the board is not empty, then the position is taken
    else 
        return true
    end
end

# check if it's a valid move
def valid_move?(board, position)
    # translate input (1-9) into array indexing (0-8) on the board
    input = position.to_i - 1
    # if the position is not taken, and the array indexing is between 0 & 8 
    # then it's a valid move, or else it's not a valid move
    if !position_taken?(board, input) && input.between?(0,8)
        return true
    else
        return false
    end
end

# to encapsulate logic of a single complete turn
def turn(board)
    # ask user for their move by position 1-9
    puts "Please enter 1-9:"
    # recieving user input
    input = gets.strip
    # if the move is invalid, ask for a new move until valid move is received
    if !move(board, input, current_player(board))
        puts "Number is not valid"
        puts "Please enter 1-9:"
        input = gets.strip
    end
    # display the board with the valid move
    display_board(board)
end

# count the number of turns that has been played
def turn_count(board)
  # no one has played yet so start the turn count at 0
   counter = 0
   # checking each slot space on the board 
   board.each do |space|
   # if the space on the board has an "X" or "O", increment turn count by 1
       if  space == "X" || space == "O"
           counter += 1
       end
   end
   # return the current number of turns 
    return counter
end

# determine whose turn is it - X's turn or O's turn
def current_player(board)
    # if the turn count is an even number, it's "X" turn, otherwise, it's "O" turn
    turn_count(board).even? ? "X" : "O"
end

# is a winning combination on the board?
def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
      # win_combination is a 3 element array of indexes that compose of a win, [0, 1, 2]
      # grab each index from the win_combination that composes a win
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
     
    # load the value of the board at win_index_1
    position_1 = board[win_index_1]
    # load the value of the board at win_index_2
    position_2 = board[win_index_2]
    # load the value of the board at win_index_3
    position_3 = board[win_index_3]
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
        # return winning combination indexes as an array 
        return win_combination
    end
  end
    # return false if there is no winning combination present in the board
    return false
end


# indicate a full board
def full?(board)
    # return true if all spaces on the board has either "X" or "O" in it
    board.all? {|space| space == "X" || space == "O"}
end

# indicate a draw game
def draw?(board)
  # return true if the board has not been won and board is full
    if !won?(board) && full?(board)
        return true
    # return false if the board is not won and the board is not full
    elsif !won?(board) && !full?(board)
        return false
    # return false if the board is won
    else won?(board)
        return false
    end
end

# indicate if the game is over due to a win, a draw, or a full board
def over?(board)
    # returns true if the board has been won, is a draw, or is full
    if won?(board) || draw?(board) || full?(board)
        return true
    else
     # return false if the game is not over  
        return false
    end
end

# announce who won the game
def winner(board)
    # the winning combination won on the board
    win_combination = won?(board)
    # if the game is won as indicated by the winning combination, 
    # return the token ("X" or "O") indicated by the 0 array index
    # of the combination that won on the board
    if win_combination
        return board[win_combination[0]]
    end
end

# start the game
def play(board)
    # allow players to take turns until the game is over
    turn(board) until over?(board) 
    # if the game was won, congratulate the winner
    if won?(board)
        puts "Congratulations #{winner(board)}!"
    # else if the game was a draw, tell the player it's a "Cat's Game!"
    elsif draw?(board)
        puts "Cats Game!"
    end
end