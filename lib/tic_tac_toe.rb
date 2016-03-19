WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [2, 4, 6],
  [0, 4, 8]
]
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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position) == true

    char = current_player(board)

    move(board, position, char)
    display_board(board)
  else
    turn(board)
  end
end
# Define your play method below

def play(board)
  if won?(board) == false
    while over?(board) != true
      turn(board)
    end
  end

  if draw?(board) == true
    puts "Cats Game!"
  end

  winner = winner(board)
  puts "Congratulations #{winner}!"

end


def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def won?(board)
  WIN_COMBINATIONS.each do |first|
    win_index_1 = first[0]
    win_index_2 = first[1]
    win_index_3 = first[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      winarray = Array.new
      winarray << win_index_1 << win_index_2 << win_index_3
      return true
    end
  end
  return false
end

def full?(board)
  board.all? do |spot|
    spot == "X" || spot == "O"
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  elsif won?(board) == false && full?(board) == false
    return false
  elsif won?(board) == true
    return false
  end
end

def over?(board)
  if won?(board) == true || full?(board) == true || draw?(board) == true
    return true
  else
    return false
  end

end

def winner(board)
    x_item = 0
    o_item = 0
  board.select do |spots|

    if spots == "X"
      x_item += 1
    elsif spots == "O"
      o_item += 1
    end
  end
  if x_item > o_item
    return "X"
  elsif o_item > x_item
    return "O"
  end
end

def turn_count(board)
  counter = 0
  board.each do |spots|
    if spots == "X" || spots == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  x_id = "X"
  o_id = "O"
  if turn_count(board) == 0
    return x_id
  elsif turn_count(board) % 2 == 0
    return x_id
  else
    return o_id
  end
end

