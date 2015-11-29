WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # bottom row
  [0,3,6],  #left column
  [1,4,7],  #mid column
  [2,5,8],  #right column
  [0,4,8],  #left diag
  [2,4,6]   #right diag
  ]

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
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |spot|
    if spot == "X" || spot == "O"
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

def won?(board)
  empty = true
  board.none? do |int|
   if int == "X"  || int == "O"
    empty = false
  end
  end

  if empty == false
  WIN_COMBINATIONS.any? do |win_combo|
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]

    pos_1 = board[win_index_1]
    pos_2 = board[win_index_2]
    pos_3 = board[win_index_3]

    if pos_1 == "X" && pos_2 == "X" && pos_3 == "X"
      return win_combo
    elsif pos_1 == "O" && pos_2 == "O" && pos_3 == "O"
      return win_combo
    else
      false
    end
  end
      end
end

def full?(board)
  if !board.include?(" ") && !board.include?(nil)
    return true
  end
end

#board doesn't contain blank spaces
#also include return true for a draw

def draw?(board)
  if !won?(board) && full?(board)
    return true
  elsif !won?(board) && full?(board)
    return false
  elsif won?(board)
    return false
  end
  end


def over?(board)
  if won?(board) || draw?(board) ||  full?(board)
    return true
   end
end

def winner(board)
  if won?(board)
    if board[won?(board)[0]]  == "X"
       return "X"
    elsif board[won?(board)[0]] == "O"
       return "O"
    end
 else
   return nil
 end
end


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



