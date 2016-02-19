

class TicTacToe

  def initialize(board)
    @board = board
    @board = Array.new(9," ")
  end

  Win_combinations = [
  [0,1,2],[3,4,5],[1,4,7],[2,5,8],[0,3,6],[6,7,8],[0,4,8],[2,4,6]
  ]

  def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player=current_player(board))
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
  input = gets
  if valid_move?(board, input)
    move(board, input)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |choices|
    if "#{choices}" == "X" || "#{choices}" == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def full?(board)

  board.each do |positions|
    if positions == " "
      return false
    else
      true
    end
  end
end

def draw?(board)
  if won?(board)
    false
  else if full?(board)
    true
    return true
  else
    false
  end
end
end

def won?(board)

WIN_COMBINATIONS.detect do |win_combination|

    position_1 = board[win_combination[0]]
    position_2 = board[win_combination[1]]
    position_3 = board[win_combination[2]]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")

      return [win_combination[0],win_combination[1],win_combination[2]]
  else
      false
  end
  end
end


def over?(board)
  if won?(board)
    true
  else if draw?(board)
    true
  else if full?(board)
    true
    return true
  else false
  end
end
end
end

def winner(board)
  win = won?(board)
  if won?(board)
    true
    return board[win[0]]
  end
end

def play(board)
  while over?(board) != true
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end


end





