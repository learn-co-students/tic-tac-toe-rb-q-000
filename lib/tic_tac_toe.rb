# Helper Methods
def welcome_message
  puts "Welcome to Tic Tac Toe!"
end

def turn_count(board)
  board.select { |element| element != " "}.length
end

def current_player(board)
  turn_count(board).odd? ? "O" : "X"
end

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
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [6,4,2],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def won?(board)
  WIN_COMBINATIONS.detect do |wc|
    p1 = board[wc[0]]
    p2 = board[wc[1]]
    p3 = board[wc[2]]
    if (p1 == "X" && p2 == "X" && p3 == "X") || (p1 == "O" && p2 == "O" && p3 == "O")
      return [wc[0], wc[1], wc[2]]
    end
  end
  return false
end

def full?(board)
  board.none? { |element| element == " " }
end

def draw?(board)
  win = won?(board).is_a?(Array)
  if win && full?(board)
    false
  elsif full?(board)
    true
  else
    false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board).is_a?(Array)
    combo = won?(board)
    return "O" if board[combo[0]] == "O"
    return "X" if board[combo[0]] == "X"
  else
  end
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board).is_a?(String)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end