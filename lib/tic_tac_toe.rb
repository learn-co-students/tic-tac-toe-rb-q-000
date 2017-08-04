#Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, index, team)
  board[index] = team
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def valid_move? (board, index)
  !position_taken?(board, index) && index.between?(0, 8)
end

def position_taken?(board, index)
  board[index] != " " && board[index] != "" && board[index] != nil
end

def turn_count(board)
  turns = 0
  board.each{|tile| turns += 1 if  tile == "X" || tile == "O"}
  turns
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

WIN_COMBINATIONS = [
  [0,1,2], #Top horizontal
  [3,4,5], #Mid horizontal
  [6,7,8], #Bot horizontal
  [0,3,6], #Left vertical
  [1,4,7], #Mid vertical
  [2,5,8], #Right vertical
  [0,4,8], #Downward diagonal
  [2,4,6] #Upward diagonal
]

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if combination.all?{|index| board[index] == "X"} || combination.all?{|index| board[index] == "O"}
      return combination
    end
  end
  false
end

def full?(board)
  board.all?{|tile| !(tile.nil? || tile == " " || tile == "")}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  if won?(board) && won?(board).all?{|index| board[index] == "X"}
    "X"
  elsif won?(board) && won?(board).all?{|index| board[index] == "O"}
    "O"
  end
end


#One turn
def turn(board)
  validated = false
  until validated == true
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)
    validated = valid_move?(board, index)
  end
  move(board, index, current_player(board))
  display_board(board)
end

#Play loop
def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
