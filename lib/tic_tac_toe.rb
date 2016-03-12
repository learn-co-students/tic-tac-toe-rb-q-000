# Define your WIN_COMBINATIONS constant
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


def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def move(board,position,value)
  board[position.to_i-1]=value
end

def won?(board)
    WIN_COMBINATIONS.each do |combination|
      if combination.all? { |position| board[position] == 'X'}
        return combination
       elsif combination.all? { |position| board[position] == 'O'}    # Seperate for 'X' and 'O' otherwise it fails if it's a draw
        return combination
      end
    end
    return false
end

def full?(board)
  board.all?{|position| position=="X"||position=="O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board)||won?(board)
end

def winner(board)
  if !over?(board)
    return nil
  end
  board[won?(board)[0]]=="X"? "X":"O"
end

def position_taken?(board,position)
  board[position]=="X"||board[position]=="O"? true : false
end

def valid_move?(board,position)
  if (!(position.is_a? Integer))
    position = position.to_i-1
   else
    position = position -1
  end
  (0..8) === position &&!(position_taken?(board,position))? true : false
end

def turn_count(board)
  count = 0
  board.each do |cell|
    count += (cell == "X" || cell == "O") ? 1 : 0
  end
  return count
end

def current_player(board)
   turn_count(board)%2==0? "X" : "O"
end

def turn(board)
  puts("Please enter 1-9:")
  position = gets.strip
  if valid_move?(board,position)
    move(board,position,current_player(board))
    display_board(board)
  else
    puts("invalid move")
    display_board(board)
    turn(board)
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if (over?(board))
    if(draw?(board))
      puts "Cats Game!"
    elsif (won?(board))
      puts "Congratulations #{winner(board)}!"
    end
  end
end



