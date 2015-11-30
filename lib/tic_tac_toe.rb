
def display_board(board) 
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, value = "X")
  position = position.to_i
  board[position - 1] = value
end

def position_taken?(board, position)
  if board[position] == (" ") || board[position] == ("") || board[position] == nil
    false
  elsif board[position] == ("X") || board[position] == ("O") 
    true
  end
end

def valid_move?(board, position)
  move = position.to_i - 1
  if move.between?(0 , 8) 
    if !position_taken?(board, position.to_i - 1)
      true
  else
    false
    end
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  until valid_move?(board, input)
    puts "Please choose an empty square"
    input = gets.strip
  end
  move(board, input, value=current_player(board))

  
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
  if turn_count(board).to_i.even?
     "X"
  else
     "O"
  end
end


WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
]
 def won?(board)
  
  WIN_COMBINATIONS.detect do |win_combination|
      win_index_1 = win_combination [0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"

  return win_combination
    else
      false
    end
  end
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
  if won?(board) != nil
    won?(board).each do |win_num|
      return board[win_num][0]
    end
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board) != nil
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
