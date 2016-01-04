WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
  ]

# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  print "Please enter 1-9: "
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    puts "Wrong move buddy!"
    turn(board)
    return
  end
  display_board(board)
end

# Count number of current moves
def turn_count(board)
  count = 0
  board.each do |cell|
    count = (cell != "" && cell != " ")? count + 1 : count
  end
  count
end

# Return current player
def current_player(board)
  (turn_count(board) % 2 == 0)? "X" : "O"
end

# Check if game is won.
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    match = combo.all? { |i| board[i] == "X" } || combo.all? { |i| board[i] == "O" }
    if match then return combo end
  end

  false
end

# Check if board is full
def full?(board)
  board.all? { |cell| !(cell.nil? || cell == " ") }
end

# Ckeck for draw
def draw?(board)
  full?(board) && !won?(board)
end

# Check if the is over
def over?(board)
  won?(board) || draw?(board)
end

# Return winning token
def winner(board)
  if combo = won?(board)
    board[combo[0]]
  end
end

# Run the game utill a player wins or there is a draw
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