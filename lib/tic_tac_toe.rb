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
    puts "Pleas enter 1-9"
    input=gets.strip
    if !valid_move?(board,input)
      turn(board)
    end
  move(board,input,current_player(board))
  display_board(board)   
end

def turn_count(board)
  board.count{|turns| turns=="X" || turns=="O"}
end

def current_player(board)
  if turn_count(board)==0 || turn_count(board)==2 || turn_count(board)==4 || turn_count(board)==6 || turn_count(board)==8
    return "X"
else
  return "O"
  end
end

def won?(board)

  WIN_COMBINATIONS.each do | combos |
    if board[combos[0]] == "X" && board[combos[1]] == "X" && board[combos[2]] == "X"
      return combos
    elsif board[combos[0]] == "O" && board[combos[1]] == "O" && board[combos[2]] == "O"
      return combos
    end
  end
  false
end



    
def full?(board)
  board.all?{|spots| spots =="X" || spots == "O"}
  end


def draw?(board)
   !won?(board) && full?(board)
end

def over?(board)
   won?(board) || draw?(board)
end


def winner(board)
  WIN_COMBINATIONS.each do |win_combo|
    if win_combo.all? {|spots| board[spots] == "X" }
       return "X"
    elsif win_combo.all? {|spots| board[spots] == "O"}
       return  "O"
    end
    end 
    nil 
end



def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end   
end
