# Define your play method below
def play(board)

  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations " + winner(board) + "!"
  elsif draw?(board)
    puts "Cats Game!"
  else
  end


end



# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end


#def position_taken?(board, location)
#  board[location] != " " && board[location] != ""
#end


# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [3,4,5],  # Middle row
  [0,1,2],  # Top row
  [6,7,8],  # Middle row
  [0,3,6],  # Middle row
  [1,4,7],  # Middle row
  [2,5,8],  # Middle row
  [0,4,8],  # Middle row
  [2,4,6],  # Middle row
]

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    if board[win_combo[0]]!=" " && board[win_combo[0]]==board[win_combo[1]] && board[win_combo[1]]==board[win_combo[2]]
      return win_combo
    end
  end
  return false
end

def full?(board)
  return board.count(" ") == 0
end

def draw?(board)
  return !won?(board) && full?(board)
end

def over?(board)
  return won?(board) || draw?(board)
end

def winner(board)
  if !won?(board)
    return nil
  else
    return board[won?(board)[0]]
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


def turn_count(board)
  return 9 - board.count(" ")
end

def current_player(board)
  turn_count(board)%2 == 0 ? "X" : "O"
end