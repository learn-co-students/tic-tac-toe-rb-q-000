
def play(board)
if over?(board) == true
    if draw?(board)
      puts "Cats Game!"
    elsif won?(board)
      puts "Congratulations #{winner(board)}!"
    else
    end
else turn(board)

  end
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
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

def input_to_index(input)
    input.to_i - 1
end
#ttt-8-trun
def position_to_index(position)
    position.to_i - 1
end

def move(board, index, token = "X")
  board[index] = token
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else board[index] == "X" || board[index] == "O"
    return true
  end
end

def valid_move?(board, position)
    index = position.to_i - 1 # position_to_index(position)
    if index.between?(0, 8) && !position_taken?(board, index)
    then true
    else false
    end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  index = position_to_index(position)
  token = current_player(board)
  if valid_move?(board, position)
      move(board, index, token)
      display_board(board)
  else
      turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |board_positions| if board_positions != " "
                                      counter += 1 end
  end
  return counter
end

def current_player(board)
  counter = turn_count(board)
  if counter.even?
    return "X"
  else
    return "O"
  end
end
#
def won?(board)
  board.any? do |position| (position == "X" || position == "O") end

    WIN_COMBINATIONS.detect do |win_combination| 
        win_index_1 = win_combination[0]
        win_index_2 = win_combination[1]
        win_index_3 = win_combination[2]
        position_1 = board[win_index_1]
        position_2 = board[win_index_2]
        position_3 = board[win_index_3]
        position = [position_1, position_2, position_3]
        position.all? {|p| p == "X"} || position.all? {|p| p == "O"}
      end
end

def full?(board)
  board.all? {|p| p != " "}
end

def draw?(board)
  won?(board) == nil && full?(board) == true
end

def over?(board)
  won?(board) || full?(board) || full?(board)
end

def winner(board)
  if won?(board) == nil
    return nil
  else board[won?(board)[0]]
  end
end


