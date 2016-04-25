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

def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, character)  
  position -= 1  
  board[position] = character  
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position = position.to_i - 1
  !position_taken?(board, position) && position.between?(0, 8)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip.to_i  
  if valid_move?(board, position.to_s)
    move(board, position, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turn = 0
  board.each do |position|    
    if position == "X" || position == "O"
      turn += 1
    end
  end  
  turn
end

def current_player(board)
   turn_count(board).even?  ? "X" : "O"  
end

def won?(board)
  WIN_COMBINATIONS.any? do |win_combination|  
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
 
    position_1 = board[win_index_1] 
    position_2 = board[win_index_2] 
    position_3 = board[win_index_3]  
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")      
      return win_combination  
    end
  end
end

def full?(board)
  board.none? do |position|
    position == " " || position.nil?
  end
end

def draw?(board)
   full?(board) && !won?(board)    
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)  
  if won?(board) 
    winning_position = won?(board)[0]
    if board[winning_position] == "X"
      return "X"
    elsif board[winning_position] == "O"
      return "O"
    end
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end