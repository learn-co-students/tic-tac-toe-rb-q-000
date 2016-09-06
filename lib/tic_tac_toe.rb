
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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input = user_input.to_i
  user_input = (user_input - 1)
end

def move(board, index, player)
  board[index] = player
  board
end

def position_taken?(board, index)
  board[index] != " " && board[index] != "" && board[index] != nil
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index) == true
end

def turn(board)
  puts ""
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "That was not a valid move. Try again."
    turn(board)

  end
end


def turn_count(board)
  turns = 0
  board.each do |index|
    if index == "X" || index == "O"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |row|
    board[row[0]] == board[row[1]] &&
    board[row[1]] == board[row[2]] &&
    position_taken?(board, row[0])
  end
end
def full?(board)
  board.all? {|index| index == "X" || index == "O"}
end

def draw?(board)
 !won?(board) && full?(board)
end

def over?(board)
 draw?(board) || won?(board)
end

def winner(board)
  if winner = won?(board)
    board[winner.first]
  end
end

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
