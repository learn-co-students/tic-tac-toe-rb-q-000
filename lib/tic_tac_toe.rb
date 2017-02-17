# Helper Methods
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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
=begin
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "Invalid input, enter again"
    turn(board) #recursive method
  end
=end
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  while !valid_move?(board, index)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end

  move(board, index, current_player(board))
  display_board(board)
end

def turn_count(board)
  turns = 0
  board.each do |token|
    if token != "" && token != " "
      turns+=1
    end
  end

  return turns

end

def current_player(board)
  if turn_count(board)%2 == 0
    "X"
  else
    "O"
  end
end

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

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
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
  [2,4,6]
]

def won?(board)

  WIN_COMBINATIONS.detect do |combination|
    (board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X") ||
    (board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O")
  end #returns winning combination or nil

end

def full?(board)
  !(board.any?{ |token| token == "" || token == " "}) #returns true if full
end

def draw?(board)
  if won?(board)
    false
  elsif full?(board)
    true
  else
    false
  end

end

def over?(board)
 won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  else
    nil
  end

end
