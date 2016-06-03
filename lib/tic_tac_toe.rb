# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
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

# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below

def play(board)
    count = 0
    while count < 9
      turn(board)
      count += 1
    end
end

def current_player(board)
    turn = turn_count(board)
    if turn % 2 == 0
       "X"
     else
       "O"
     end
end

def turn_count(board)
  counter = 0
  board.each do |elem|
    if elem == "X" || elem == "O"
        counter += 1
    end
  end
  return counter
end


def full?(board)
  !board.include? " "
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
    board[won?(board).detect {|i| i}] if won?(board)
end

def draw?(board)
  !won?(board) && full?(board)
end

def won?(board)
    WIN_COMBINATIONS.detect do |win_combination|
      win_index_1 = win_combination[0] #index 0
      win_index_2 = win_combination[1] #index 1
      win_index_3 = win_combination[2] #index 2

      position_1 = board[win_index_1] # load the value of the board at win_index_1
      position_2 = board[win_index_2] # load the value of the board at win_index_2
      position_3 = board[win_index_3] # load the value of the board at win_index_3

      (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
      (position_1 == "O" && position_2 == "O" && position_3 == "O")

    end

end
