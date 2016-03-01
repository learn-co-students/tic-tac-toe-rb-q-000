def move(board, position, token)
  board[position.to_i-1] = token
end

def turn_count(board)
  counter = 0
  board.each do |token|
    if token == "X" || token == "O"
      counter += 1
    else
    end
  end
  counter
end

#A method to determine the current player
def current_player(board)
  turn_count(board).even? == true ? "X" : "O"
end

#To display the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if !valid_move?(board, input)
    turn(board)
  end
  move(board, input, current_player(board))
  display_board(board)
end

def position_taken?(board, position)
  board[position] != " " && board[position] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
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



# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], #Top Row
  [3, 4, 5], #Middle row
  [6, 7, 8], #Bottom row
  [0, 3, 6], #Left column
  [1, 4, 7], #Middle column
  [2, 5, 8], #Right column
  [0, 4, 8], #Left-to-right descending diagonal
  [2, 4, 6] #Right-to-left descending diagonal
]


#WON? Method
def won?(board)
  WIN_COMBINATIONS.detect do |win_type|  
    position_taken?(board, win_type[0]) &&
    board[win_type[0]] == board[win_type[1]] &&
    board[win_type[1]] == board[win_type[2]] 
  end
end

#full? method

def full?(board)
  board.none?{|full_board| full_board==" "}
end

#draw? method 
def draw?(board)
  full?(board) && !won?(board)
end

#over? method
def over?(board)
  won?(board) || draw?(board)
end

#winner? method
def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end


