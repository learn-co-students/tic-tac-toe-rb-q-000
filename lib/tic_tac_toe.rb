WIN_COMBINATIONS = [
    [0,1,2], #Top row
    [3,4,5], #Middle row
    [6,7,8], #Bottom row
    [0,3,6], #Left column
    [1,4,7], #Middle column
    [2,5,8], #Right column
    [0,4,8], #Diagonal 1
    [2,4,6], #Diagonal 2
    ]
def won?(board)
  
  WIN_COMBINATIONS.detect do |win_combo|

  board[win_combo[0]] == board[win_combo[1]] &&
  board[win_combo[1]] == board[win_combo[2]] &&
  position_taken?(board,win_combo[0])

  #   return win_combo
  
  
  #elsif board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O"
   #  return win_combo
  #else
   # false
  #end
  #else
   # false
  end
end 

def full?(board)
  if board.all?{|taken| taken != " "}
    return true
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end

end

def over?(board) 
  if full?(board)|| won?(board) || draw?(board)
    return true
  end
  
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def display_board(board)

  
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "

end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  
  while !valid_move?(board,position)
    puts "invalid move, please enter again"
    position=gets.strip
  end 
  move(board,position,char = current_player(board))
  display_board(board)
end

def valid_move?(board,position)
  if position.to_i.between?(1,9) && !position_taken?(board,position.to_i-1) 
    return true
  end
  
end
# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board,position)
  (board[position] != " ") && (board[position] != "") && (board[position] != nil)
end  

def move(board,pos,char = "X")

    pos = pos.to_i - 1

    def update_array_at_with(array,position,value)
    array[position] = value
    end
    
   update_array_at_with(board,pos,char)
   
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position != " " 
    counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board)
  if turn_count(board)%2==0 
    return "X"
  else
    return "O"
  end    
end  

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
