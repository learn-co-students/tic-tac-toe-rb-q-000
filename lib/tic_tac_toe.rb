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

# Keep track of the number of plays
def turn_count(board)
  count = 0
  board.each do |element|
    if element == "X" || element == "O"
      count += 1
    end
  end
  count
end

# Based on the number of plays, keep track of current player.
def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0, 1, 2], # top row
                    [3, 4, 5], # middle row
                    [6, 7, 8], # bottom row
                    [0, 3, 6], # left column
                    [1, 4, 7], # middle column
                    [2, 5, 8], # right column
                    [0, 4, 8], # diagonal top left
                    [2, 4, 6]] # diagonal top right

def won?(board)
  WIN_COMBINATIONS.each do |win_condition|
    win_index_1 = win_condition[0]
    win_index_2 = win_condition[1]
    win_index_3 = win_condition[2]

    board_index_1 = board[win_index_1]
    board_index_2 = board[win_index_2]
    board_index_3 = board[win_index_3]

    if (board_index_1 == "X" && board_index_2 == "X" && board_index_3 == "X") || (board_index_1 == "O" && board_index_2 == "O" && board_index_3 == "O")
      return win_condition
    end
  end
  return false
end

def full?(board)
  board.none? { |element| !position_taken?(board, board.index(element)) }
end

def draw?(board)
  full?(board) && !won?(board) ? true : false
end

def over?(board)
  full?(board) || won?(board) || draw?(board) ? true : false
end

def winner(board)
  winning_combo = won?(board)

  over?(board) ? board[winning_combo[0]] : nil
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

def play(board)
  while !over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    
  else
    puts "Cats Game!"
  end
end