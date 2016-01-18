

WIN_COMBINATIONS = [
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right column
  [0,4,8],  # Diagonal top left to bottom right
  [2,4,6]  # Diagonal top right to bottom left
]

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def draw?(board)
  return true if full?(board) == true && won?(board) == false
end

def full?(board)
  return true if (board.count("X") + board.count("O")) == board.count
end

def move(board,location,char="X")
  board[location.to_i - 1] = char
  board
end

def over?(board)
  return true if won?(board) || draw?(board) || full?(board)
end

def play(board) # This is the main method to play the game!
  until over?(board) == true do
    board = turn(board)
  end

  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end

end

def position_taken?(board, position)
  return true if board[position] == "X" || board[position] == "O"
  return false
end

def turn(board)
  valid = false
  until valid == true do
    puts "Please enter 1-9:"
    input = gets.chomp
    valid = valid_move?(board, input)
  end
  board = move(board, input, current_player(board))
  display_board(board)
  board
end

def turn_count(board)
  board.count("X") + board.count("O")
end

def valid_move?(board, position)
  i = position.to_i - 1
  return false if i > 8 || i < 0
  return true if position_taken?(board,i) == false
end

def won?(board)

  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
      return combo
    elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
      return combo
    end
  end
  return false
end


def winner(board)
  win_combo = won?(board)
  #binding.pry
  if win_combo == false
    return nil
  elsif board[win_combo[0]] == "X"
    return "X"
  elsif board[win_combo[0]] == "O"
    return "O"
  end
end