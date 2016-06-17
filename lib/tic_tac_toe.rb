
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end
def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index) 
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
  
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end
# Define your play method below
def play(board)
    until over?(board)
      turn(board)
    end
    if won?(board)
        puts "Congratulations #{winner(board)}!"
    end
    if draw?(board) != false
        puts "Cats Game!" 
    end
end

def won?(board)
  WIN_COMBINATIONS.each do |win|
    winnr = ""
    win.each do |pos|
      if board[pos] == "X"
        winnr << "X"
      elsif board[pos] == "O"
        winnr << "O"
      end
      if winnr == "XXX" || winnr == "OOO"
        return win
      end
    end
  end
  return false
end

def draw?(board)
  full = full?(board)
  won = won?(board)
  if won != false
    return false
  elsif full
    return true 
  end
    return false
end


def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end

def full?(board)
  board.all?  { |element|  element == "X" || element == "O" }
end

def winner(board)
  if won?(board) != false
    winner = board[won?(board)[0]]
  end
end

def turn_count(board)
  count = 0
  board.each do |x|
    if x == "X" || x == "O"
      count += 1
    end
  end
  count
end



