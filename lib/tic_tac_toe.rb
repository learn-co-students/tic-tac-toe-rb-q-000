# define constants
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

# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def won?(board)
  WIN_COMBINATIONS.any? do |combination|
    if combination.all? { |x| board[x] == "X" } || combination.all? { |o| board[o] == "O"}
      return combination
    end
  end
end

def full?(board)
  board.select { |index| index != " " }.length == 9 ? true : false
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  end
end

def over?(board)
  if full?(board) || draw?(board) || won?(board)
    true
  end
end

def turn_count(board)
  # returns count of elements in board array that are X or O
  board.select { |position| position == "O" || position == "X" }.length
end

def current_player(board)
  if turn_count(board) == 0
    "X"
  else
    turn_count(board).even? ? "X" : "O"
  end
end

def winner(board)
  sequence = won?(board)
  sequence.is_a?(Array) ? board[sequence[0]] : nil
end

# Gameplay methods
def play(board)
  until over?(board)
    turn(board)

    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cats Game!"
    end
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip

  if valid_move?(board, input) 
    move(board, input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player="X")
  board[location.to_i-1] = current_player
end