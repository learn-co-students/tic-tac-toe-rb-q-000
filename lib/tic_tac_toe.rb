

# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your move method here!
def move (board, input, char = "X")
  position = input.to_i - 1
  def update_array_at_with(array, position, char)
    array[position] = char
  end
  update_array_at_with(board, position, char)
end

 # re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
    def position_taken?(board, position)
     if board[position] == "  " || board[position] == " " || board[position] == "" || board[position] == nil
        return false
     elsif board[position] == "X" || board[position] == "O"
        return true
      end
    end
 # code your #valid_move? method here
  def valid_move?(board, position)
    move = position.to_i-1
      if move.between?(0, 8)
        if !position_taken?(board, move)
              true
          else
            false
          end
      #else false, board space is open   
      # else 
      #     if position.between?(0, 8) == true
      #       return true
      #     end
      end
  end

# def turn(board)
#   puts "Please enter 1-9:"
#   input = gets.strip
#   until valid_move?(board, input)
#     puts "Invalid entry. Try again:"
#     input = gets.strip
#   end
#   move(board, input, value=current_player(board))

  
#   display_board(board)
# end
def turn (board)
  # ask for input
  puts "Please enter 1-9:"
  # get input
  input = gets.strip
    # ask for input again until you get a valid input
    until valid_move?(board, input)
      puts "Invalid entry. Try again:"
      input = gets.strip
    end
  move(board, input, value=current_player(board))   
  # show the board
  display_board(board)
end

def turn_count(board)
  counter = 0
   board.each do |move|
    if move == "X" || move == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end


# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6], # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right column
  [0,4,8],  # Left top diagonal
  [2,4,6]  # Right top diagonal 
]

def won?(board)
  WIN_COMBINATIONS.detect do |combos| 
    board[combos[0]] == board[combos[1]] &&
    board[combos[1]] == board[combos[2]] &&
    position_taken?(board, combos[0])
    end
end

def full?(board)
  board.all?{|i| i == "X" || i == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if winner_combo = won?(board)
    board[winner_combo.first]
  end
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board) != nil
    puts "Congratulations #{winner(board)}!"
  else 
    puts "Cats Game!"
  end
  # turn = 1
  # #start loop and call #turn
  # while turn <=9 
  #   turn += 1
  #   turn(board)
  # end
end
