WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #first column
  [1, 4, 7], #second column
  [2, 5, 8], #third column
  [0, 4, 8], #first diagonal
  [2, 4, 6]  #second diagonal
]

def display_board(board)
  
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  
end

def move(array, location, character = 'X')
    location = location.to_i - 1
    array[location] = character
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, position)
  position = position.to_i 
  if position.between?(1,9) && !position_taken?(board, position - 1)
     return true
  else 
     return false
  end
end

def turn_count(board)
  counter = 0
  board.each do |element|
  if element != " " 
    counter+=1 
  end
end
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
  input = gets.strip
  end
  display_board(board)
end

def won?(board)
   WIN_COMBINATIONS.detect do |numbers|
     if numbers.all? { |position| board[position] == "X"  }
      return numbers
     elsif numbers.all? { |position| board[position] == "O"  }
      return numbers
     else
      false
     end
  end
end

def full?(board)
  board.all? { |position| position == "X" || position == "O" }
end

def draw?(board)
if won?(board)
  return false
else
  board.all? do |position|
      position == "X" || position == "O"
   end
 end 
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    if board[won?(board)[0]] == "X"
      return "X"
      else 
      return "O"
    end
    else draw?(board)
        return nil
    end
  end

def play(board)
until over?(board)
  turn(board)
end
if draw?(board)
  puts "Cats Game!"
else 
  puts "Congratulations #{winner(board)}!"
end
end