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

def display_board(board)
  print " #{board[0]} | #{board[1]} | #{board[2]} "
  print "-----------"
  print " #{board[3]} | #{board[4]} | #{board[5]} "
  print "-----------"
  print " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, character = "X")
  board[location.to_i - 1] = character
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  else
    true
  end
end

def valid_move?(board, position)
  if position.to_i.between?(1, 9)
    if !position_taken?(board, position.to_i - 1)
      true
    end
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if !valid_move?(board, position)
    turn(board)
  else  
  move(board, position, character = "X")
  end
  display_board(board)
end

def turn_count(board)
  current_move = 0
  board.each do |index|
    if index == "X" || index == "O"
      current_move += 1
    end
  end
  current_move
end

def current_player(board)
  turn_count(board) == 0 ? "X" : "O"
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |win|
    position_taken?(board, win[0]) && board[win[0]] == board[win[1]] && board[win[1]] == board[win[2]]
  end
end

def full?(board)
  all_full = board.all? do |element|
    element == "X" || element == "O"
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  elsif won?(board)
    false
  else
    false
  end
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    won?(board).each do |index|
      if position_taken?(board, index) && board[index] == "X"
        return "X"
      elsif position_taken?(board, index) && board[index] == "O"
        return "O"
      else
        return nil
      end
    end 
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
   


  