# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
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

def won?(board)
 WIN_COMBINATIONS.detect  do | combination| 
    position_taken?(board,combination[0]) && (board[combination[0]] == board[combination[1]] && board[combination[2]] == board[combination[1]])

  end
  
end

=begin def full?(board)
 board.each_index do |position| 
  if !position_taken?(board,position)
    false
    break
  else
    true
  end
end

end
=end

def full?(board)
   board.all?{|pos| pos == "X" || pos == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
 
end


def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board)
    win_array = won?(board)
    board[win_array[1]]
  elsif draw?(board)
    nil
    
  end


end

def turn_count(board)
  board.count{|t| t == "X" || t == "O"}
end

def current_player(board)
  if turn_count(board) % 2 == 0
    current_player = "X"

  else
    current_player = "O"
  end
end
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
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input,current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

# Define your play method below
def play(board)
  #counter = 1
  #while(counter <= 9)
   # turn(board)
    #counter += 1
  #end
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end