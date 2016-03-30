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

def position_taken?(board, position)
  !(board[position].nil? || board[position] == " ")
end

# my version below, solution version above
# def position_taken?(board, position)
#   board[position] == "X" || board[position] == "O"
# end


## worried about the inconsistency of position (user vs array index) in the r-spec.  keep an eye on this as you may need to change this later to get the game to actually work properly
def valid_move?(board, position)
  position.to_i.between?(1,9) && position_taken?(board, position.to_i-1) == false
end

def turn(board)
    puts "Make your move! (Pick a position 1-9.)"
    input = gets.strip
    if valid_move?(board, input)
      move(board, input, current_player(board))
      display_board(board)
    else
      turn(board)
    end
end

def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

# my version of #won? below, used the solution version above
# def won?(board)
#   WIN_COMBINATIONS.find {|combo| combo.all? {|position| board[position] == "X"} || combo.all? {|position| board[position] == "O"}}
# end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

# my version of #full? below, which also doesn't use #position_taken?
# def full?(board)
#   board.all? {|position_contents| !(position_contents.nil? || position_contents == " ")}
# end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

# not sure why checking for a draw is necessary given that we're already checking if the game is over... only put it in to make the tests happy
def play(board)
  until over?(board) || draw?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end