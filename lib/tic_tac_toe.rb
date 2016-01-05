# define a WIN_COMBINATIONS constant
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


# accept a board. print the current board representation.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


# accept a board, player's desired location, character ("X" or "O"). update array with character.
def move(board, location, character = "X")
  board[location.to_i-1] = character
end


# evaluate user input against the board. if position is free, return false ("not taken"), otherwise return true ("taken")
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end


# accept a board and a position. return true if the move is valid (present on the board, not filled). return false or nil if not valid (not present on the board, already filled)
def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end


# encapsulate the logic of a single complete turn: ask for input, get input, is move valid? (if yes make the move | if no start over and ask for input), display board after move is complete
def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  if valid_move?(board, input)
    move(board, input, current_player(board)) 
  else
    turn(board)
  end
  display_board(board)
end


# return the number of turns that have been played
def turn_count(board)
  filled_array = board.select do |position_filled|
    position_filled == "X" || position_filled == "O"
  end
  return filled_array.length
end


# accept a board. use the #turn_count method to determine if it is "X"'s turn or "O"'s
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end


# accept a board. return false/nil if there is no win combination present. return the winning array if there is a win.
def won?(board)
  WIN_COMBINATIONS.each do |combination|
  combination.all? do |occupied|
    if position_taken?(board, occupied) == true
      if board[combination[0]] == board[combination[1]] && board[combination[0]] == board[combination[2]]
        return combination
      end
   end
  end
end
return false
end


# accept a board. return true if every element in the board contains either an "X" or an "O".
def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end


# accept a board. return true if the board has not been won and is full. return false if the board is not won and the board is not full. return false if the board is won.
def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  end
end


# accept a board. return true if the board has been won, is a draw, or is full.
def over?(board)
  draw?(board) || won?(board)
end


# accept a board. return the token, "X" or "O" that has won the game given a winning board.
def winner(board)
  the_winner = won?(board)
  if the_winner
    board[the_winner[0]]
  else
    return nil
  end
end


# take turns until game is over. if game is won, congratulate winner. if game is a draw, tell the players it's a draw.
def play(board)
  if over?(board) != false
    if won?(board) != false
      winner = winner(board)
      puts "Congratulations #{winner}!"
      return
    else
      puts "Cats Game!"
      return
    end
  else
    turn(board)
    play(board)
  end
end