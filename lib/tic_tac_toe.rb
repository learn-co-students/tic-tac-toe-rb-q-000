def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn(board)
  puts "Please enter 1-9:"
  play = gets.strip
  until valid_move?(board,play)
    puts "That isn't a valid move, please play again!"
    play = gets.strip
  end
move(board,play,current_player(board))
display_board(board)
end

def turn_count(board)
  turns_played = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      turns_played = turns_played +1
    end
  end
  return turns_played
end

def current_player(board)
  if turn_count(board).odd?
    return "O"
  else
    return "X"
  end
end

def move(board,loc,char = "X")
  board[loc.to_i-1] = char
end

def valid_move?(board,position)
  if position_taken?(board,position.to_i-1)
    return false
  elsif !((position.to_i >= 1) && (position.to_i <= 9))
    return false || nil
  else
    return true
      end
end

def position_taken?(board, position)
  if (board[position] == "") || (board[position] == " ") || (board[position] == nil)
    return false
  elsif (board[position] == "X") || (board[position] == "O")
    return true
    end
end

def play(board)
until over?(board) do
    turn(board)
    winner = won?(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
   else
     puts "Cats Game!"
  end
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], #bottom row
  [0,3,6], #left col
  [1,4,7], #mid col
  [2,5,8], #right col
  [0,4,8], # left diag
  [2,4,6], #right diag
  ]


def won?(board)
  WIN_COMBINATIONS.detect do |yes|
    (board[yes[0]] == board[yes[1]]) && (board[yes[0]] == board[yes[2]]) && ((board[yes[0]] == "X") || (board[yes[0]] == "O"))
  end
end

def full?(board)
  result = board.detect {|fullness| fullness == " "}
  if result == " "
    return false
  else
    return true
  end
end

def draw?(board)
  if won?(board) == nil && full?(board) == true
    return true
  else
    return false
  end
end
def over?(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  return true
  elsif draw?(board)
    puts "Cats Game!"
  return true
  elsif full?(board)
    puts "full"
    else
    return false
  end
end

def winner(board)
  result = won?(board)
  if result != nil
    return board[result[0]]
  else
    return nil
  end
end

