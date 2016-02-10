# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #top row win
  [3,4,5], #middle row win
  [6,7,8], #bottom row win
  [0,3,6], #left column win
  [1,4,7], #middle column win
  [2,5,8], #right column win
  [0,4,8], #topL to bottomR diag win
  [2,4,6] #topR to bottomL diag win
]

#Display Board
def display_board(board)
  print " #{board[0]} | #{board[1]} | #{board[2]} "
  print "-----------"
  print " #{board[3]} | #{board[4]} | #{board[5]} "
  print "-----------"
  print " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Move
def move(board,position,char="X")
  board[position.to_i-1] = char
end

#Position Taken?
def position_taken?(board,position)
  !(board[position].nil? || board[position]==" ")
end

#Valid Move
def valid_move?(board,position)
  (position.to_i.between?(1,9)) && (position_taken?(board,position.to_i-1)==false)
end

#Turn
def turn(board)
  puts "Please enter 1-9"
  input = gets
  if valid_move?(board,input) == false
    input = gets
  end
  board[input.to_i-1] = current_player(board)
  display_board(board)
end

#turn_count
def turn_count(board)
  count = 0
  board.each do |cell|
    if cell == "X" || cell == "O"
    count+=1
    end
  end
  return count
end

#current_player
def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

#Won Method
def won?(board)
WIN_COMBINATIONS.each do |win_combination|
    position_1 = board[win_combination[0]]
    position_2 = board[win_combination[1]]
    position_3 = board[win_combination[2]]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end
  end
  return false
end

def full?(board)
  board.all? {|cell| cell == "X" || cell == "O"}
end

def draw?(board)
  !(won?(board)) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end


def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

# until over, ask for turn, check turn_count, input
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








