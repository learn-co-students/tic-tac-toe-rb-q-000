#MAIN METHOD
def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

#display board
def display_board(board)
  separator = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts separator
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts separator
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#makes move, supports turn
def move(board, location, x_or_o = current_player(board))
  board[location.to_i-1] = x_or_o
  board #returns board in complete, otherwise it'll just return X or O
end

#checks if valid move, supports turn
def valid_move?(board, index)
  index = index.to_i - 1
  if position_taken?(board, index) == false && index.between?(0,8)
    return true
  else
    return false
  end
end

#support
def turn_count(board)
  count = board.select {|i| i == "X" || i == "O"}
  count.size
end

#support
def current_player(board)
  if turn_count(board).even?
    return "X" 
  else
    return "O"
  end
end

#gets player input and makes a move if valid
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
    if valid_move?(board, input)
    move(board, input)
    else
    turn(board)
    end
  display_board(board)
end


def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 4, 8], #diagonal left to bottom right
  [2, 4, 6], #diagonal right to bottom left
  [0, 3, 6], #left column
  [1, 4, 7], #center column
  [2, 5, 8], #right column
]

def won?(board)
  won = false
  WIN_COMBINATIONS.each do |combo|
    first = combo[0]
    second = combo[1]
    third = combo[2]

    position_1 = board[first]
    position_2 = board[second]
    position_3 = board[third]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return combo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return combo
    else
      won = false
    end
  end

  return won
end

def full?(board)
  #if all position_takens evaluate to true
  #then board.all? will evaluate to true
  (0..8).to_a.all? {|spot| position_taken?(board, spot)}
end

def draw?(board)
  !won?(board) && full?(board)
end


def over?(board)
  #won?(board) will return an array, which is truthy
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  #position of winner
  if won?(board)
    position = won?(board)[0] 
    return board[position]
  end
end