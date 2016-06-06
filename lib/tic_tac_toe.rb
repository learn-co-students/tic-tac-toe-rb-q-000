# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
                    # Horizantol wins:
                    [0,1,2], # top row
                    [3,4,5], # middle row
                    [6,7,8], # bottom row
                    # -----

                    # Vertical wins:
                    [0,3,6], # column 1
                    [1,4,7], # column 2
                    [2,5,8], # column 3
                    # -----

                    # Diagonal wins:
                    [0,4,8], # back-slash line-up win
                    [2,4,6], # forward-slash line-up win
                    # -----
]


def display_board(board)
 row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
 seperator = "-----------"
 row2 = " #{board[3]} | #{board[4]} | #{board[5]} "
 row3 = " #{board[6]} | #{board[7]} | #{board[8]} "

puts row1
puts seperator
puts row2
puts seperator
puts row3

end


# code your input_to_index and move method here!
def input_to_index(str)
  buffer = str.to_i()
  index = buffer - 1
end



def move(array, index, value)
  #sets the board's spot to -value-
  array[index] = value
end


# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


# code your #valid_move? method here
def valid_move?(board, index)
  if( index.between?(0, 8) && !position_taken?(board, index))
    true
  end

end



def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip) # get user input and process
  if valid_move?(board, index)
    move(board, index, current_player(board)) # call with default argument -value- = "X"
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)

  counter = 0
  board.each do |cell_content|
    if cell_content == "X" || cell_content == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)

  WIN_COMBINATIONS.each do |win_combinations|
    win_index_1 = win_combinations[0]
    win_index_2 = win_combinations[1]
    win_index_3 = win_combinations[2]

    win_by_X = board[win_index_1] == "X" && board[win_index_2] == "X" && board[win_index_3] == "X"
    win_by_O = board[win_index_1] == "O" && board[win_index_2] == "O" && board[win_index_3] == "O"

    win_detected = win_by_X || win_by_O

    if win_detected
      return win_combinations
    end

  end

  false # No win detected inside #each, false is for "There is no win in game"

end


def full?(board)
  board.each do |token|
    if token != "X" && token != "O"
      return false
    end
  end

  true
end


def draw?(board)

  no_win = !won?(board)
  board_full = full?(board)

  if(no_win && board_full)
    true
  else
    false
  end

end


def over?(board)

  is_over = won?(board) || draw?(board)

end


def winner(board)

  output = won?(board)
  if(output)
    return board[output[0]]
  end
end


def play(board)

  while(!won?(board) && !over?(board))
    turn(board)
  end

  if(won?(board))
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end
