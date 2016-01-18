WIN_COMBINATIONS = [
  [0, 1, 2], 
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
  ]

  board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts [" #{board[0]} | #{board[1]} | #{board[2]} ", "-----------", " #{board[3]} | #{board[4]} | #{board[5]} ", "-----------", " #{board[6]} | #{board[7]} | #{board[8]} "]
  end

def move(board, position, player)
  board[position.to_i-1] = player
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  else 
   true
  end
end

def valid_move?(board, position)
  if position.to_i - 1 >= 0 && position.to_i - 1 <= 8 && position_taken?(board, position.to_i - 1) == false
    true
  else 
    false
  end
end

def turn(board)
  puts "Please input 1-9:"
  position = gets.strip
  if valid_move?(board, position) == true
    move(board, position, current_player(board))
  else
    until valid_move?(board, position) == true
      puts "Please input 1-9:"
      position = gets.strip 
    end
      move(board, position, current_player(board))
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |spot|
    if spot == "X" || spot == "O"
      counter +=1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).odd? == true
    return "O"
  else
    return "X"
  end
end

player = current_player(board)

def won?(board)
  won = false
  WIN_COMBINATIONS.each {|win_combination|
    all_X = win_combination.all? {|win_index| board[win_index] == "X"}
    all_O = win_combination.all? {|win_index| board[win_index] == "O"}
    if all_X == true || all_O == true
      won = win_combination
  end}
  return won
end
      

def full?(board)
  empty = board.include?(" ")
  if empty == true
    false
  else
    true
  end
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    true
  elsif won?(board) == false 
  false
end
end



def over?(board)
  if won?(board) != false
    true
  elsif full?(board) == true
    true
  elsif draw?(board) == true 
    true
  else
    false
  end
  end

def winner(board)
if won?(board) != false
    if won?(board).all? {|i| board[i] == "X"}
      return "X"
    elsif won?(board).all? {|i| board[i] == "O"}
      return "O"
    end
  end
end


def play(board)

  until over?(board) == true 
    turn(board)
    end
    if won?(board) != false && winner(board) == "X"
      puts "Congratulations X!"
    elsif won?(board) != false && winner(board) == "O"
      puts "Congratulations O!"
    elsif draw?(board) == true
      puts "Cats Game!"
    end
end






