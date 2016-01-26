WIN_COMBINATIONS = [
[0,1,2], #Top Row
[3,4,5], #Middle Row
[6,7,8], #Bottom Row
[0,3,6], #left vert
[1,4,7], #middle vert
[2,5,8], #Right Vert
[0,4,8], #TL to RB diag
[2,4,6] #TR to BL diag
]
FINAL_WIN = []
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(array,position, player="X")
  array[position.to_i - 1]=player
end

def position_taken?(board,position)
  if board[position] == " "
    false
  elsif board[position]==""
    false
  elsif board[position]==nil
    false
  else
    true
  end
end

def valid_move?(array,space)
  position=(space.to_i-1)
  if position.between?(0,8) && !(position_taken?(array,position))
    true
  else
    false
  end
end

def turn(board)
  ok_move=false
  while ok_move==false 
    puts "Please enter 1-9:"
    player=current_player(board)
    input=gets.strip
    if valid_move?(board,input)
      move(board,input,player)
      ok_move=true
    else
      puts "Invalid Move! Try again."
    end
  end    
end

def turn_count(board)
  spaces_left=board.select{|i| i==" "}
  current_turn=(9-spaces_left.count)
  return current_turn
end

def current_player(board)
  if turn_count(board)==0 || turn_count(board)==2 || turn_count(board)==4 || turn_count(board)==6 || turn_count(board)==8
    return "X"
else
  return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combos|
    if board[combos[0]]=="X" && board[combos[1]]=="X" && board[combos[2]]=="X"
        win="X"
        return true
      elsif board[combos[0]]=="O" && board[combos[1]]=="O" && board[combos[2]]=="O"
       win="O"
        return true
      else
         false
    end
      
    if win=="X" || win=="O"
        FINAL_WIN[0]=win
    end
  end
end

ARRAY=[0,1,2,3,4,5,6,7,8]
def full?(board)
  ARRAY.all? do |board_pos|
    position_taken?(board,board_pos)
  end
end

def draw?(board)
  win_ox=won?(board)
  if win_ox==true
    return false
  elsif full?(board)==true
    return true
  else
    return false
   end
end

def over?(board)
  over_xo= won?(board)
  if over_xo==true 
    return true
  elsif draw?(board)==true
    return true
  else
    return false
  end
end

def winner(board)
    if won?(board)==true
     return current_player(board)
   else
    nil
   end
end


def play(board)
  while over?(board)==false
    turn(board)
    win_xo=won?(board)
    if win_xo==true
      puts "Congratulations, #{winner(board)}!"
    elsif draw?(board)== true
      puts "Cats game!"
    end
    display_board(board)
  end    
end
