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

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def won?(board)
    winner = nil
    WIN_COMBINATIONS.detect do |win_combination| # since were iterating [0,1,2] all these are win combination are checking the spots [0,1,2]
      win_index_1 = win_combination[0]
      position_1 = board[win_index_1]

      win_index_2 = win_combination[1]
      position_2 = board[win_index_2]

      win_index_3 = win_combination[2]
      position_3 = board[win_index_3]

if position_1 == "X" && position_2 == "X"  && position_3 == "X"
  winner = win_combination
elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
  winner = win_combination
  #else position_1 == " " && position_2 == " " && position_3 == " "
  #false
        end
        break if winner
      end
    return winner #psuedo else statement
  end
  #def won?(board)
  #  WIN_COMBINATIONS.detect do |combo|
  #  board[combo[0]] == board[combo[1]] &&
  #  board[combo[1]] == board[combo[2]] &&
  #  position_taken?(board, combo[0])
  #end
  #end


def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

#def turn(board)
#   puts "Please enter 1-9:"
#   user_input = gets.chomp
 #user_input = input_to_index(user_input)
  # if valid_move?(board,user_input); true
  #   move(board,user_input, x = "X")
  #   display_board(board)
 #else
  # turn(board)
 #end
# end

def position_taken?(board, index)
  board[index]== "X" || board[index] == "O"
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn_count(board)
  board.count{|position| position == "X" || position == "O"}
end

def move(board, index, player)
  board[index] = player
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end
