
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2],
]
   # Middle row
    # ETC, an array for each win combination]

def display_board(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])

        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts " ----------- "
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts " ----------- "
        puts " #{board[6]} | #{board[7]} | #{board[8]} "

  end

def move(board, place, char="X")
  place = place.to_i
  board[place - 1] = char
  return board
end

def turn(board)
  puts "Please enter 1-9:"
  position=gets
  if valid_move?(board, position)==true
    move(board, position, token="X")
  elsif valid_move?(board, position)==false
    turn(board)
  end
  display_board(board) 
end

def turn_count(board)
  counter=0
  board.each do |element|
    if element=="X" || element=="O"
    counter+=1
    end
  end
return counter
end

def current_player(board)
  if turn_count(board)%2==0
    board[turn_count(board)]="X"
  else
    board[turn_count(board)]="O"
  end 
end

def valid_move?(board, int)
  int = int.to_i-1
  if int.between?(0,8) && position_taken?(board, int)==false
    return true
  elsif int.between?(0,8)== false || position_taken?(board, int)==true
    return false
  end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.


def position_taken?(board, int)
  if (board[int]==" ") || (board[int]=="")
    return false
  elsif (board[int]=="X") || (board[int]=="O")
    return true
  elsif (board[int]==nil)
    return false
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    return combo if combo.all? {|position| board[position] == 'X'}
    return combo if combo.all? {|position| board[position] == 'O'}
  end
  return false if board.all? { |position| position != " "}
  return false if board.all? { |position| position == " "}
end

def full?(board)
  board.all? {|element| element == "X" || element == "O" }
end


def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) 
end

def winner(board)
    WIN_COMBINATIONS.each do |combo|
    return "X" if combo.all? {|position| board[position] == 'X'}
    return "O" if combo.all? {|position| board[position] == 'O'}
  end
  return nil
end

def play(board)


  until over?(board) 
    turn(board) 

end

    if winner(board)=="X"
      puts "Congratulations X!"
    elsif winner(board)=="O"
      puts "Congratulations O!"
    elsif draw?(board)==true 
      puts  "Cats Game!"
  end

end
 

 
 




