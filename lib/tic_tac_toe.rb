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
    move(board, input)
  else
    turn(board)
  end
  display_board(board)
end

# Define your play method below
def play(board)
  play = 0
  until play == 9
    turn(board)
    play += 1
  end
end

def turn_count(board)
  counter = 0
    board.each do |move|
      if (move == "X" || move == "O")
        counter += 1
      end
    end
return counter
end

def current_player(board)
  counter = 0
    board.each do |move|
      if (move == "X" || move == "O")
        counter += 1
      end
    end

  if (counter % 2 == 0)
    return "X"
  elsif (counter % 2 != 0)
    return "O"
  end
end

# Helper Method
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
  result = false
  WIN_COMBINATIONS.each do |combinations|
    win_index_1 = combinations[0]
    win_index_2 = combinations[1]
    win_index_3 = combinations[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if result == false
      if ((position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O"))
      result = combinations
      else
        result = false
      end
    end
  end
  result
end

def full?(board)
  board.all?{|elements| !(elements == " " || elements == nil)}
end

def draw?(board)
  return true if (won?(board) == false && full?(board) == true)
  return false if (won?(board) != false || full?(board) == false )
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  winning_location = won?(board)
  if winning_location
    board[winning_location[0]]
  else return nil
  end
end