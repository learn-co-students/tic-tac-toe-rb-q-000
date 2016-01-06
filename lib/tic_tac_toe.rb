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

def display_board(board = " ")
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your move method here!
def move(board,move,current_player= "X")
  board[move.to_i - 1] = current_player
end

def position_taken?(board, position)
  !(board[position].nil? || board[position] == " ")
end

def valid_move?(board,position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
  #move_integer = position.to_i
  #move= move_integer - 1
  #if position is within board and not taken = valid move
  #if move.between?(0,8) && position_taken?(board,position) == false
   # true
  # if position is within board and taken = invalid move
  #elsif move.between?(0,8) && position_taken?(board,position)
   # false
  # if position is outside the board, its an invalid move
  #elsif move < 0 || move > 8
   # false
  #end
end

def turn(board)
  puts "Please enter 1-9:"
  position= gets.strip
    if valid_move?(board,position)
      move(board,position,current_player(board))
    else
    until valid_move?(board,position) == true #|| turn_count(board) == 9
      puts "Please select an empty cell in range 1-9"
      position= gets.strip

      end
    end
  display_board(board)
end
#else
      #turn(board)
    #end
  #display_board(board)
#end

def turn_count(board)
  counter = 0
    board.each do |spot|
        if spot != " "
         counter += 1
        end
    end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  elsif turn_count(board) % 2 != 0
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") #|| (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination     # return the win_combination indexes that won.
    elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end
  end
  return false
end

def full?(board)
  board.all? {|x| x == "X" || x == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
  x =  won?(board) #[0,4,8]
  y = x[2].to_i
  board[y]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end

  #while counter < 10 do
   # turn(board)
    #counter += 1
    #if won?(board)
     # puts "Congratulations #{winner(board)}, you won!"
      #break
   # end
#end
  #puts "Cats Game!"
#end

  #counter = 0
  #while counter < 10
   # turn(board)
    #turns += 1
    #if won?(board)
     # puts "Congratulations #{winner(board)} !!!"
    #elsif draw?(board)
    #puts "Cats Game!"
    #end
  #end

