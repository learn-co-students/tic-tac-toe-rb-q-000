# WIN_COMBINATIONS = [
#   [0,1,2],
#   [3,4,5],
#   [6,7,8],
#   [0,3,6],
#   [1,4,7],
#   [2,5,8],
#   [0,4,8],
#   [6,4,2]
# ]

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # First column
  [1,4,7], # second column
  [2,5,8], # third column
  [0,4,8], # diagonal win from left
  [6,4,2]  # diagonal win from right
]

# def play(board)
#   while !over?(board)
#     turn(board)
#   end

#   if won?(board)
#     puts "Congratulations #{winner(board)}!"
#   elsif draw?(board)
#     puts "Cats Game!"
#   end
# end

def play(board)
#  binding.pry
  while !over?(board)
    turn(board)
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else puts "Cats Game!"
  
  end
end

# def display_board(board)
#   puts " #{board[0]} | #{board[1]} | #{board[2]} "
#   puts "-----------"
#   puts " #{board[3]} | #{board[4]} | #{board[5]} "
#   puts "-----------"
#   puts " #{board[6]} | #{board[7]} | #{board[8]} "
# end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# def valid_move?(board, input)
#   input.to_i.between?(1,9) && !position_taken?(board, input.to_i-1)
# end

def valid_move?(board, position)
#  binding.pry
  !position_taken?(board, position.to_i-1) && position.to_i.between?(1,9)

end

# def won?(board)
#   WIN_COMBINATIONS.detect do |combo|
#     board[combo[0]] == board[combo[1]] &&
#     board[combo[1]] == board[combo[2]] &&
#     position_taken?(board, combo[0])
#   end
# end

def won?(board)

  WIN_COMBINATIONS.find do |i|
     board[i[0]] == board[i[1]] &&
     board[i[1]] == board[i[2]] &&
     position_taken?(board, i[0])
  end
end

# def full?(board)
#   board.all?{|token| token == "X" || token == "O"}
# end

def full?(board)
  board.all?{|i| i == "X" || i == "O"}
end

# def draw?(board)
#   !won?(board) && full?(board)
# end

def draw?(board)
  full?(board) && !won?(board)
end

# def over?(board)
#   won?(board) || draw?(board)
# end

def over?(board)
  won?(board) || draw?(board)
end

# def turn(board)
#   puts "Please enter 1-9:"
#   input = gets.strip
#   if !valid_move?(board, input)
#     turn(board)
#   end
#   move(board, input, current_player(board))
#   display_board(board)
# end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if !valid_move?(board, input)
    turn(board)
  end
  move(board, input, current_player(board))
  display_board(board)
end

# def position_taken?(board, location)
#   !(board[location].nil? || board[location] == " ")
#   # Creates a stop on RSpec
#   # !(board[location].nil? || board[location] == "")
# end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    return false
  elsif board[position] == "X" || board[position] == "O"
    return true
  end
end

# def current_player(board)
#   turn_count(board) % 2 == 0 ? "X" : "O"
# end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

# def turn_count(board)
#   board.count{|token| token == "X" || token == "O"}
# end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

# def move(board, location, player = "X")
#   board[location.to_i-1] = player
# end

def move(board, input, char = "X" )
  board[input.to_i-1] = char
end

# def winner(board)
#   if winning_combo = won?(board)
#     board[winning_combo.first]
#   end
# end

def winner(board)
  if i = won?(board)
    board[i.first]
  end
end




























