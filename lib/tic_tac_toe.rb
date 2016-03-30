WIN_COMBINATIONS = [
  [0,1,2], #Top row
  [3,4,5], #Middle row
  [6,7,8], #Bottom row
  [0,3,6], #left column
  [1,4,7], #Middle Column
  [2,5,8], #Right COlumn
  [0,4,8], #Diagonal 1
  [6,4,2]  #Diagonal 2
  ]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def move(board, position, char="X")
  board[position.to_i-1] = char
end


def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end


def turn_count(board)
  turns = 0
  board.each do |pos|
    if pos == "X" || pos == "O"
      turns += 1
    end
  end
  turns
end


def current_player(board)
  played = turn_count(board)
  if played % 2 == 0
    return "X"
  else
    return "O"
  end
end

def full?(board)
  return (position_taken?(board, 0) && position_taken?(board, 1) && position_taken?(board, 2) && position_taken?(board, 3) && position_taken?(board, 4) && position_taken?(board, 5) && position_taken?(board, 6) && position_taken?(board, 7) && position_taken?(board, 8))
end

def empty?(board)
  return (!position_taken?(board, 0) && !position_taken?(board, 1) && !position_taken?(board, 2) && !position_taken?(board, 3) && !position_taken?(board, 4) && !position_taken?(board, 5) && !position_taken?(board, 6) && !position_taken?(board, 7) && !position_taken?(board, 8))
end

def won?(board)
  if empty?(board)
    return false
  end

  WIN_COMBINATIONS.each do |entry|
    #Are they they all taken
    positions_taken = (position_taken?(board, entry[0]) && position_taken?(board, entry[1]))
    positions_equal = ((board[entry[0]] == board[entry[1]]) && (board[entry[1]] == board[entry[2]]))
    if (positions_taken && positions_equal)
      return entry
    end
  end
  return false
end


def draw?(board)
  return (full?(board) == true && won?(board) == false)
end

def over?(board)
  return (won?(board) || draw?(board) || full?(board))
end

def winner(board)
  w = won?(board)
  if w == false
    return nil
  end
  return board[w[1]]
end

def play(board)
  while over?(board) == false
    turn(board)
  end
  if won?(board) != false
    char = winner(board)
    puts "Congratulations #{char}!"
  end
  if draw?(board) == true
    puts "Cats Game!"
  end
end

