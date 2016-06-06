WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input = user_input.to_i
  user_input = user_input - 1
end

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    return true
  elsif board[index] != " " || board[index] != "" || board[index] != nil
    return false
  end
end

def valid_move?(board, index)
  if position_taken?(board, index)
    return nil
  end
  if index + 1 >= 1 && index + 1 <= 9
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, value = "X")
    return display_board(board)
  else
    until valid_move?(board, index)
      return turn(board)
    end
  end
end

def turn_count(board)
  count = 0
  board.each do |value|
    if value != " "
    count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board).even? == false
    return "O"
  else
    return "X"
  end
end

def won?(board)
   WIN_COMBINATIONS.each do |win_combination|
     tokens = [board[win_combination[0]],
               board[win_combination[1]],
               board[win_combination[2]]]
     if tokens.all?{ |token| token == "X" }
       puts "Congratulations X!"
       return win_combination
     elsif tokens.all?{ |token| token == "O" }
       puts "Congratulations O!"
       return win_combination
     end
   end
   false
 end

def full?(board)
  if board.none?{|token| token == " " }
    return true
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  end
end

def winner(board)
  win_combination = won?(board)
  if win_combination
    board[win_combination[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  end
end
