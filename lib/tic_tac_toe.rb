# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # NW-SE diagonal
  [6,4,2]  # NE-SW diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board,location,current_player="X")
  board[location.to_i - 1] = current_player
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

# Define your play method below
def play(board)
  turn(board) until over?(board)
  puts "Congratulations #{winner(board)}!" if won?(board)
  puts "Cats Game!" if draw?(board)
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    tokens = [board[win_combination[0]],
              board[win_combination[1]],
              board[win_combination[2]]]
    all_tokens_X = tokens.all?{ |token| token == "X" }
    all_tokens_O = tokens.all?{ |token| token == "O" }
    return win_combination if all_tokens_X || all_tokens_O
  end
  false
end

def full?(board)
  board.none?{|token| token == " " }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || draw?(board) || won?(board)
end

def winner(board)
  win_combination = won?(board)
  if win_combination
    board[win_combination[0]]
  end
end

def turn_count(board)
  board.count {|token| token == "X" || token == "O"}
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

