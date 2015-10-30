WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, input, placeholder='X')
  board[input.to_i-1] = placeholder
  board
end

def position_taken?(board,position)
  if board[position] == ' ' || board[position] == '' || board[position] == nil
    false
  else
    true
  end
end

def valid_move?(board,position)
  if !position_taken?(board,position.to_i-1) && position.to_i > 0 && position.to_i < 10
    true
  else
    false
  end
end

def turn_count(board)
  turns = 0
  board.each do |space|
    if space == 'X' || space =='O'
      turns += 1
    end
  end
  turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    current_player = 'X'
  else
    current_player = 'O'
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    x_wins = win_combination.all? do |index|
      board[index] == 'X'
    end

    o_wins = win_combination.all? do |index|
      board[index] == 'O'
    end

    if x_wins || o_wins
      return win_combination
    end
  end
  return nil
end

# returns true if all the positions on the board are taken
def full?(board)
  full = Array(0..8).all? do |position|
    position_taken?(board, position)
  end
end

# returns false unless the board is full and there is no winner
def draw?(board)
  false
  if full?(board) && !won?(board)
    true
  end
end

# returns false unless there is a winner or a draw
# the game isn't over till it's over!
def over?(board)
  false
  if won?(board) || draw?(board)
    true
  end
end

# returns the value of the board at the first position of the winning row
def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    puts "Sorry, that is not a valid move."
    display_board(board)
    turn(board)
  end
  display_board(board)
end

def play(board)
  display_board(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cats Game!"
  end
end

