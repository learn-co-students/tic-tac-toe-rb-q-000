<<<<<<< HEAD

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

=======
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
  [6,4,2]  # Right Diagonal
]

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]
  position_1 = board[win_index_1] # load the value of the board at win_index_1
  position_2 = board[win_index_2] # load the value of the board at win_index_2
  position_3 = board[win_index_3] # load the value of the board at win_index_3

  if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
    return win_combination
      # return the win_combination indexes that won.
  end  
  end
  if (board[0] == " " && board[1] ==" " && board[2] ==" " && board[3] ==" " && board[4] ==" " && board[5] ==" " && board[6] ==" " && board[7] ==" " && board[8] ==" " )
    return false
  end
  return false
end

def full?(board)
   if board.any?{|i| i == " "}
     return false
  else
  if draw?(board)
    return true
  end
  end
end

def draw?(board)
  WIN_COMBINATIONS.each do |win_combination|
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]
  position_1 = board[win_index_1] # load the value of the board at win_index_1
  position_2 = board[win_index_2] # load the value of the board at win_index_2
  position_3 = board[win_index_3] # load the value of the board at win_index_3

  if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
    return false
      # return the win_combination indexes that won.
  end  
  end
  if (board[0] == " " || board[1] ==" " || board[2] ==" " || board[3] ==" " || board[4] ==" " || board[5] ==" " || board[6] ==" " || board[7] ==" " || board[8] ==" " )
    return false
  end
  return true
  end

def over?(board)
  if won?(board) == false      
    if draw?(board)
      return true
    else
         return false
      end
  else
    return true
  end
end
  


def winner(board)
   winning_board = won?(board)
   if won?(board)
     if board[winning_board[0]] == "X"
       return "X"
     else board[winning_board[0]]== "O"
       return "O"
     end
   else
     return nil
   end
end

def turn_count(board)
  count = 0
  board.each do |move|
    if move == "X" || move == "O"
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
# Helper Methods
def display_board(board)

  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, letter = "#{current_player(board)}")
  position = position.to_i
  board[position-1] = letter
 
end

# code your #position_taken? method here!
def position_taken?(board, position)
  if (board[position] =="") || (board[position] ==" ") || (board[position] ==nil)
    false
    else
    if (board[position] =="X") || (board[position] =="O")
    true
    end
  end
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input)
  else
    turn(board)
  end
  display_board(board)
end

#Play Method
def play(board)
  
until over?(board) 
    turn(board)   
  end
 if won?(board)
       puts "Congratulations #{winner(board)}!" 
  elsif draw?(board)
    puts "Cats Game!"
  end
end
  


>>>>>>> 79616b61f6dd0fd8dc1b6d36167bd48c8f7d6755
