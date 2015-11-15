# Defines WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8], 
  [0, 3, 6], 
  [1, 4, 7], 
  [2, 5, 8], 
  [0, 4, 8], 
  [6, 4, 2]
]

# Defines display_board that accepts a board and prints
# out the current state.

board = [" ", " ", " ",
         " ", " ", " ",
         " ", " ", " "]

def display_board(board)

puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "

end

def move(board, position, char = "X")
pos = position.to_i
board[pos - 1] = char

end

# the next two methods work together to check if a player can make the desired move

def valid_move?(board, position)

  if position.to_i < 1 || position.to_i > 9
    return false
  elsif position_taken?(board, position.to_i - 1) == true
    return false
  else 
    return true
  end

end

def position_taken?(board, position)

  if board[position.to_i] == "X" || board[position.to_i] == "O"
    return true
  else
    return false
  end

end

# one turn(takes player input and excutes if valid)
def turn(board)

puts "Please enter 1-9:"
position = gets.chomp

  if valid_move?(board, position) == false
    turn(board)
  else
    move(board, position, current_player(board))
    display_board(board)
  end

end

def turn_count(board)
  count = 0

  board.each do |i|
    if i == "X" || i == "O"
      count += 1
    end
  end

  return count
end

def current_player(board)

  if turn_count(board).even?
    return "X"
  else
    return "O"
  end

end

def won?(board)

  WIN_COMBINATIONS.each do |i|
    if i.all? {|j| board[j] == "X"} || i.all?{|j| board[j] == "O"}
      return i
    end
  end

  return false
end

def full?(board)

  board.none? {|i| i == " " }

end

def draw?(board)

  if won?(board) == false && full?(board) == true
    return true
  else
    return false
  end

end

def over?(board)

  if draw?(board) == true || won?(board) != false
    return true
  end

end

def winner(board)

  if won?(board) == false
    return nil
  end
  
  i = won?(board)

  if board[i[0]] == "X"
    return "X"
  else
    return "O"
  end 

end




def play(board)

  while over?(board) !=true
  display_board(board)
  char = current_player(board)
  turn(board)
  end

  if draw?(board)
    puts "Cats Game!"
  elsif winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  end

end




