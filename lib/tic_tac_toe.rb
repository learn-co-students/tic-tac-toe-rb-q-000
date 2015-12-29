
# Define your play method below
def play(board)
  while !over?(board) && !draw?(board) && !won?(board)
    turn(board)
    current_player(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cats Game!"
  end
end
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  # ETC, an array for each win combination
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle Column
  [2,5,8], # Right Column
  [0,4,8], # Left diagonal
  [6,4,2] # Right Diagonal
  ]

def won?(board)
  winning_flag = false
    WIN_COMBINATIONS.each do |win_combination|
      if win_combination.all?{|win_index| board[win_index]=="X"} 
        return "X"
        winning_flag = true
      elsif win_combination.all?{|win_index| board[win_index]=="O"}
        return "O"
        winning_flag = true
      end
    end
    return winning_flag   
end

def full?(board)
  board.all?{|item| item=="X" || item == "O"}
end

def draw?(board)
  if full?(board)==true && won?(board)==false
    return true
  else
    return false
  end
    
end

def over?(board)
  if won?(board)
    return true
  elsif full?(board) && draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
   winning_board = won?(board)
   if won?(board)== "X"
     return "X" 
   elsif won?(board) == "O"
     return "O"
   else
     return nil
   end
end

# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

# code your move method here!
def move(board, position, letter="X")
  position = position.to_i
  board[position-1] = letter
  display_board(board)
end

# code your #valid_move? method here
def valid_move?(board, position)
  position = position.to_i
  position = position-1
  if position.between?(0,9)
    if position_taken?(board, position)
      false
    else
      true
    end
  end

end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
 if valid_move?(board, position)
   move(board, position, current_player(board))
 else
   turn(board)
 end
end

def turn_count(board)
  count = 0
  board.each do |move|
    if move != " "
      count +=1
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

