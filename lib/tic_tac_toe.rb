# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end


WIN_COMBINATIONS = [
  [0, 1, 2], # Top row
  [3, 4, 5], # Middle row
  [6, 7, 8], # Bottom row
  [0, 3, 6], #1st col
  [1, 4, 7], # 2nd col
  [2, 5, 8], #3rd col
  [0, 4, 8], #top left diagonal
  [2, 4, 6] #top right diagonal
]

def won?(board)
  location = 0
  count = 0 
  while location < 9
    if position_taken?(board, location) == true
      count += 1
    end
    location += 1
  end
  if count == 9 
    return false
  end
count = 0
WIN_COMBINATIONS.each do |combination|
     if ( board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X") || (board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O")
       return combination
     else
       count += 1
     end
     if count == 8 
      return false
    end
  end
end

def full?(board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
     count += 1
    end
  end
  if count == 9 
    return true
  else 
    return false
  end
end

def draw?(board)
  if won?(board) 
    return false
  elsif won?(board) == false && full?(board) == true
    return true
  elsif won?(board) == false && full?(board) == false
    return false
  end
end

def over?(board)
  if draw?(board) == true || full?(board) == true || won?(board) == true
    return true
  end
end

def winner(board)
  if  won?(board) != false
    array = won?(board)
       all_X = array.all? do |locatie|
       board[locatie] == "X" 
        end
   if all_X == true     
    return "X"
   elsif  all_O = array.all? do |locatie|
    board[locatie] == "O"
           end
        if all_O == true
          return "O"
        end
    end    
  end
end

def display_board(board )
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "------------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "------------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, position)# code your #valid_move? method here
# code your #position_taken? method here!
def position_taken?(board, position)
  if (board[position.to_i - 1] == "") || (board[position.to_i - 1] == " ") || (board[position.to_i - 1] == nil)
    return true
  elsif (board[position.to_i - 1] == "X") || (board[position.to_i - 1] == "O")
    return false
  end
end

def between?(position) 
  if (position.to_i >= 1)&&(position.to_i <=9)
  return true 
end
end

if (between?(position) == true) && (position_taken?(board, position) == true)
  return true
end
end

def move(board, position, value)
    board[position.to_i - 1] = value
end

def turn(board)
  counter = 0 
   puts "Please enter 1-9:"
   position = gets.strip
   
   if valid_move?(board, position)
    value = current_player(board)
      move(board, position, value)
      display_board(board)
   else turn(board)
   end
end

def turn_count(board)
  count = 0
  board.each do |location| 
    if (location == "X") || (location == "O") 
      count += 1 
    end 
  end 
 return count
 end   

def current_player(board)
  a = (turn_count(board) % 2 == 0) ? "X" : "O"
   return a
end

def play(board)
  if won?(board) 
           a = winner(board)
           puts "Congratulations #{a}!"
           return "Congratulations #{a}!"
       elsif  draw?(board)
           puts "Cats Game!"
           return "Cats Game!"
       end
   
  until  over?(board) 
        turn(board)
       if won?(board) 
           a = winner(board)
           puts "Congratulations #{a}!"
           return "Congratulations #{a}!"
       elsif  draw?(board)
           puts "Cats Game!"
           return "Cats Game!"
       end
  end
  if won?(board) 
           a = winner(board)
           puts "Congratulations #{a}!"
           return "Congratulations #{a}!"
       elsif  draw?(board)
           puts "Cats Game!"
           return "Cats Game!"

       end
end