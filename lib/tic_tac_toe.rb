# Winning combinations constant
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #first column
  [1,4,7], #second column
  [2,5,8], #third column
  [0,4,8], #diagonal left to right
  [2,4,6] #diagonal right to left
  ]

# displays board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# checks if position is taken
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# checks if won if yes, returns winning combo
def won?(board)
   WIN_COMBINATIONS.detect do |combination| #ex: [0,1,2]
        board[combination[0]] == board[combination[1]] &&
        board[combination[1]] == board[combination[2]] &&
        position_taken?(board, combination[0])
   end
end

def turn_count(board)
  counts = Hash.new(0)
  board.each { |value| counts[value] += 1}
  counts["X"] + counts ["O"]
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end


# checks if board is full; if yes, returns true
def full?(board)
  turn_count(board) == 9 ? true : false
end

# checks for draw; if yes, returns true
def draw?(board)
  full?(board) & !won?(board) ? true : false
end

# if winner, outputs player that won
def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

# checks to see if game is over; if yes, returns true
def over?(board)
  won?(board) || draw?(board) || full?(board)
end

# allows player to move
def move(board, input, player = "X")
  input = input.to_i - 1
  board[input] = player
end

def valid_move?(board, position)
  position = position.to_i - 1
  if position_taken?(board, position) == true || position.between?(0,9) == false
    false
  else
     true
  end
end

def turn(board)
  #checks current player
  player = current_player(board)
  #asks user for a position to move to
  puts "Please enter 1-9:"
  position = gets.strip
  # checks if position is valid
  if valid_move?(board, position)
    # if valid, moves user to that position and displays the board
    move(board, position, player)
    display_board(board)
  else
    # if invalid, makes the player choose again
    turn(board)
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
