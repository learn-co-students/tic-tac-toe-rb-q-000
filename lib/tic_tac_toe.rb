#constant that outlines all possible winning combinations of positions on the board
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left column
  [1,4,7], #middle column
  [2,5,8], #right column
  [0,4,8], #top left to bottom right diagonal
  [2,4,6], #bottom left to top right diagonal
  ]

#method that prints the current board
board = []
def display_board(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])
    puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end

#method that makes a move on the input board with an input location and character
def move(board, position, character = "X")
  board[position.to_i - 1] = character
end

#method that determines if a given position is currently occupied
def position_taken?(board, position)
  board[position] == "X" || board[position] == "O"
end

#method that determines if a given move is valid by checking if location exists and is unoccupied
def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i - 1)
end

#method that defines how a turn is taken
def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  turns = 0
  board.each do |space|
    if space == "X" || space == "O"
      turns += 1
    end
  end
  return turns
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

#method that determines if a game has been won
def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    x_wins = win_combination.all? do |indexes|
      board[indexes] == "X"
    end
    o_wins = win_combination.all? do |indexes|
      board[indexes] == "O"
    end
    if x_wins || o_wins
      return win_combination
    end
  end
  else return false
end

#method that determines if the board is full
def full?(board)
  full = board.none? do |location|
    location == " " || location == nil
  end
end

#method that determines if the game ended in a draw
def draw?(board)
  full?(board) && !won?(board)
end

#method that determines if the game is over
def over?(board)
  full?(board) || won?(board) || draw?(board)
end

#method that determines which character won
def winner(board)
    if won?(board)
      return board[won?(board)[0]]
    else return nil
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