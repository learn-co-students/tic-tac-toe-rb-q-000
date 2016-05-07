# Helper Methods
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


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, location)
  location.between?(0,8) && !position_taken?(board, location)
end

def turn(board)
  done = false
  ctr = 0
  until done
    puts "Please enter 1-9:"
    move = gets.strip
    if valid_move?(board, move)
      ind = move.to_i
      if ctr % 2 == 0
        move(board, ind, "X")
      else
          move(board, ind, "O")
      end
      display_board(board)
      ctr += 1
      done = true
    end
  end #until
end # def

# Define your play method below
def play(board)

  i = 0
  while i < 9
      turn(board)
      i +=1
  end
end

def turn_count(board)

  counter = 0
  occupied = 0
  board.each do |cell|
    if cell != " "
      occupied +=1
    end
  end
  occupied
end

def current_player(board)
  occupied = turn_count(board)
  if  occupied % 2 == 0
    "X"
  else
    "O"
  end

end

def won?(board)

  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && board[combo[0]] != " "
      return combo
    end

  end
  return false

end

def full?(board)
  x = !board.detect{|i| i == " "} #
end

def draw?(board)

  x=full?(board)
  y=won?(board)
  x && !y
end

def over?(board)
  return draw?(board) || full?(board) || won?(board)
end

def winner(board)

  win_comb = won?(board)
  if win_comb == false
    return nil
  else
    return board[win_comb[0]]
  end

end
# code your move method here!
def move(board, location, character = "X")
  int_location = location.to_i - 1
  board[int_location] = character
end
