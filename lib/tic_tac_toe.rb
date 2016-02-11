def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
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
    [6,4,2]
  ]

 def won?(board)
  WIN_COMBINATIONS.detect  do | combination|
    position_taken?(board,combination[0]) && (board[combination[0]] == board[combination[1]] && board[combination[2]] == board[combination[1]])
  end

 end
def full?(board)
    !board.include?(" ")
end

def draw?(board)
    full?(board) && !won?(board)
end

def over?(board)
    full?(board) || draw?(board) || won?(board)
end
def winner(board)
    if won?(board)
        return board[won?(board)[0]]
    else
        return nil
    end
end
def valid_move?(board, position)# code your #valid_move? method here
  if position.to_i.between?(1,9) && !position_taken?(board, position)
    return true
  else
    return false
    end
end
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

# Define your play method below
def play(board)
until over?(board) do
  turn(board)
  end
if won?(board)
  puts "Congratulations #{winner(board)}!"
elsif draw?(board)
puts "Cats Game!"
end
end

def turn_count(board)
  count = 0
  board.each do |place|
    if place == "X" || place == "O"
      count +=1
    end
  end
  count
end



def current_player(board)
  turn_count(board) % 2 == 0? "X" : "O"
end
