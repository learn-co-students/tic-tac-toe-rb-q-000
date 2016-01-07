
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

def won?(board)
  WIN_COMBINATIONS.find{
    |combination|
    if position_taken?(board ,combination[0] )
      board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]]
    end
    }
end

def full?(board)
  board.all? {
    |cell|
    cell == "X" || cell =="O"
    }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  full?(board) || won?(board)
end

def winner(board)
  if(won?(board))
    board[won?(board)[0]]
  end
end

def turn_count(board)
  count = 0
  board.each do |spot|
    if(spot == "X" || spot == "O")
      count+= 1
    end
  end
  count
end

def current_player(board)
  if(turn_count(board) % 2 == 0)
    "X"
  else
    "O"
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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
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


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char = "X")
  board[position.to_i-1] = char
end
# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def play(board)
  while !over?(board) do
    turn(board)
    if(draw?(board))
      
      break
    end
  end
    if(won?(board))
      puts "Congratulations #{winner(board)}!"
    else
      puts "Cats Game!"
    end
end