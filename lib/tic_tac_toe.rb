
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

def move(board, position, value = "X" || "O")
  board[position=position.to_i-1] = value
end


def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position) 
  input = position.to_i-1
  if !position_taken?(board, input) && input.between?(0,8)
    true
  else 
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if !valid_move?(board, input)
    turn(board)
  end
  move(board, input, current_player(board))
  display_board(board)
end

def turn_count(board)
  count = 0
    board.each do |position|
    if "#{position}" == "X" || "#{position}" == "O"
    count += 1
    end
  end
  return count 
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
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
 
    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3
    markers = ["X", "O"]
    markers.each do |marker|
      if position_1 == marker && position_2 == marker && position_3 == marker
        return win_combination
      end
    end
 end   
  return false
end

def full?(board)
  if board.detect{|i| i == " "} 
    return false
  else
    return true
  end
end

def draw?(board)
  if full?(board)
    if won?(board)
      return false
    else 
      return true
    end
  else
    return false
  end
end


def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board) == [0,4,8]
    return "X"
  elsif won?(board) == [1,4,7]
    return "O" 
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations X!" 
  end
  if won?(board)
    puts "Congratulations O!"
  end
  if draw?(board)
    puts "Cats Game!"
  end
end

    
  




