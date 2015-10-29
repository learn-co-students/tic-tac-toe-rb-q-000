WIN_COMBINATIONS = [
  [0,1,2], 
  [3,4,5],  
  [6,7,8], 
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2],
]

#displays current board
def display_board(board= [" "," "," "," "," "," "," "," "," "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def move(board, input, player = "X")
 play = input.to_i 
 board[play -1] = player
 return board
end




def position_taken?(board, position)
  if board[position.to_i] == "X" || board[position.to_i] == "O" 
    return true
  elsif  board[position.to_i] == "" || board[position.to_i] == " " || board[position.to_i] == nil
    return false
  end  
end


def valid_move?(board, position)
  if (position.to_i-1).between?(0, 8) && position_taken?(board, position.to_i-1) == false
    true
  else
   false
 end
end


def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if  valid_move?(board,position) 
      move(board,position,token = current_player(board)) 
       puts display_board(board)
     else
      while turn(board) == false
       puts "Please enter valid move"
       turn(board)
        end     
end
end

def turn_count(board)
  counter = 0
  if board.each do |token|
    if token  == "X"|| token == "O"
      counter +=1
    end
  end
 end
 return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
end
end

def won?(board)
   topacross = WIN_COMBINATIONS[0]
   middleacross = WIN_COMBINATIONS[1]
   bottomacross = WIN_COMBINATIONS[2]
   leftdown =WIN_COMBINATIONS[3]
   middledown = WIN_COMBINATIONS[4]
   rightdown = WIN_COMBINATIONS[5]
   left_win = WIN_COMBINATIONS[6]
   right_win = WIN_COMBINATIONS[7]



      if board[topacross[0]] == "X" && board[topacross[1]] == "X" && board[topacross[2]] == "X" 
        return topacross
       
        elsif board[middleacross[0]] == "X" && board[middleacross[1]] == "X" && board[middleacross[2]] == "X" 
        return middleacross
       
        elsif board[bottomacross[0]] == "X" && board[bottomacross[1]] == "X" && board[bottomacross[2]] == "X" 
        return bottomacross
      
        elsif board[leftdown[0]] == "X" && board[leftdown[1]] == "X" && board[leftdown[2]] == "X" 
        return leftdown
     
        elsif board[rightdown[0]] == "X" && board[rightdown[1]] == "X" && board[rightdown[2]] == "X" 
        return rightdown      

        elsif board[left_win [0]] == "X" && board[left_win [1]] == "X" && board[left_win [2]] == "X" 
        return left_win 
       
        
        elsif board[right_win[0]] == "X" && board[right_win[1]] == "X" && board[right_win[2]] == "X" 
        return right_win

        elsif board[topacross[0]] == "O" && board[topacross[1]] == "O" && board[topacross[2]] == "O" 
        return topacross
       
        elsif board[middleacross[0]] == "O" && board[middleacross[1]] == "O" && board[middleacross[2]] == "O" 
        return middleacross
       
        elsif board[bottomacross[0]] == "O" && board[bottomacross[1]] == "O" && board[bottomacross[2]] == "O" 
        return bottomacross
      
        elsif board[leftdown[0]] == "O" && board[leftdown[1]] == "O" && board[leftdown[2]] == "O" 
        return leftdown
     
       elsif board[middledown[0]] == "O" && board[middledown[1]] == "O" && board[middledown[2]] == "O" 
        return middledown

        elsif board[rightdown[0]] == "O" && board[rightdown[1]] == "O" && board[rightdown[2]] == "O" 
        return rightdown      

        elsif board[left_win [0]] == "O" && board[left_win [1]] == "O" && board[left_win [2]] == "O" 
        return left_win 
       
        elsif board[right_win[0]] == "O" && board[right_win[1]] == "O" && board[right_win[2]] == "O" 
        return right_win
      else
        false
      
   end   
end

def full?(board)
  if (board[0] == "X" || board[0] == "O") && (board[1] == "X" || board[1] == "O") &&(board[2] == "X" || board[2] == "O") &&(board[3] == "X" || board[3] == "O") &&(board[4] == "X" ||board[4] ==  "O") &&(board[5] == "X" || board[5] == "O") &&(board[6] == "X" || board[6] == "O") &&(board[7] == "X" || board[7] == "O") &&(board[8] ==  "X" || board[8] == "O") 
   return true
  else
   return false
end
end


def draw?(board)
  if full?(board) && won?(board) == false
    return true
  elsif won?(board) && full?(board) == false
    return false
end
  
end

def over?(board)
  if draw?(board) || full?(board) || won?(board)
    return true
  else 
    return false
end  
end

def winner(board)
  if won?(board)
  won?(board).each do |wincombo|
    if board[wincombo] == "X"
      return "X"
    elsif board[wincombo] == "O"
      return "O"
 else
 return false
end
end
end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if winner(board) == "X" || winner(board) == "O" 
    puts "Congratulations #{winner(board)}!"
   elsif draw?(board)
      puts "Cats Game!"
  end

end
