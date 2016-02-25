WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]]

  def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, input, player = "X")
  board[input.to_i - 1] = player
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board,position)
  if position_taken?(board,position.to_i - 1) == false && (position.to_i - 1).between?(0, 8)  
  true
  else 
  false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board,input) == true 
    move(board, input, "#{current_player(board)}")
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = board[win_combination[0]]
    position_2 = board[win_combination[1]]
    position_3 = board[win_combination[2]]
  
    if position_1 != "" && position_1 != " " && position_1 == position_2 && position_2 == position_3
       return win_combination
      
    end
  end 
  return false
end

def full?(board)
  board.all? do |space|
    space == "X" || space == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  array_spaces = won?(board)
  if array_spaces 
    winning_team = board[array_spaces[0]]
  end
end

def turn_count(board)
  counter = 0
  board.each do |spot|
    if spot != " " && spot != ""
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  elsif turn_count(board) % 2 == 1
    return "O"
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  thewinner = winner(board)
  if won?(board) 
    puts "Congratulations #{thewinner}!"
  elsif draw?(board) 
    puts "Cats Game!"
  end  

end






