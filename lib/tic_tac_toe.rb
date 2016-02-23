WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Left diagonal
  [2,4,6]  # Right diagonal
]

def display_board(board)
   puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, input, char = "X")
  board[input.to_i-1] = char
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  else
    true
  end
end

def valid_move?(board, position)
  if (position.to_i-1).between?(0,8) && !(position_taken?(board, position.to_i-1))
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.chomp

  if !valid_move?(board, position)
    puts "Please enter 1-9:"
    position = gets.chomp
    move(board, position)
  else
    move(board, position, current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |player|
    if player == "X" || player == "O"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
  # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
  # grab each index from the win_combination that composes a win.
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]

  position_1 = board[win_index_1] # load the value of the board at win_index_1
  position_2 = board[win_index_2] # load the value of the board at win_index_2
  position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination # return the win_combination indexes that won.
    end
  end
   return false
 end

 def full?(board)
   board.all? do |position|
     position == "X" || position == "O"
   end
 end

 def draw?(board)
   if !won?(board) && full?(board)
     return true
   else
     return false
   end
 end

 def over?(board)
   if won?(board) || draw?(board) || full?(board)
     return true
   else
     return false
   end
 end

 def winner(board)
   if player_won = won?(board)
     return board[player_won[0]]
   else
     return nil
   end
 end

 def play(board)
   turn(board) until over?(board)
   if won?(board)
    puts "Congratulations #{winner(board)}!"
   else draw?(board)
    puts "Cats Game!"
   end
end
