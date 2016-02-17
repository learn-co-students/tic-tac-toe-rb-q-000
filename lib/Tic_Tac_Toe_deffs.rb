
###########################################################################################################
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

##############################################################################################################
def who_won?(board)
    o_index_arr=[]
    x_index_arr=[]
    board.each_index do |slot|              #MEH....
      if board [slot] == "O"
        o_index_arr << slot
      elsif board [slot] == "X"
        x_index_arr << slot
      end
    end

    counter=0
    while counter != 8
      if    (WIN_COMBINATIONS[counter] - o_index_arr).empty?   # O  winner?
        return "O won"
      elsif (WIN_COMBINATIONS[counter] - x_index_arr).empty?   # X  winner?
        return "X won"
      end
      counter += 1
    end
end
###################################################################################################
    WIN_COMBINATIONS = [
      [0,1,2],  # Top row
      [3,4,5],  # Middle row
      [6,7,8],  # bottom row
      [0,3,6],  # left column
      [1,4,7],  # Middle column
      [2,5,8],  # right column
      [0,4,8],  # diagonal 1
      [6,4,2]   # diagonal 2
    ]

##################################################################################################
def won? (board, win_possibility = WIN_COMBINATIONS)
  if board.all?{|slot| slot.include?("X" || "O")}     # returns false for an empty board
    return false
  elsif board.all?{|slot| slot.include?("X" || "O")}   #returns false for a draw
    return false
  else

    o_index_arr=[]
    x_index_arr=[]
    board.each_index do |slot|              #MEH.... I did this to manny times... << UGLY
      if board [slot] == "O"
        o_index_arr << slot
      elsif board [slot] == "X"
        x_index_arr << slot
      end
    end

    counter=0
    while counter != 8
      if    (WIN_COMBINATIONS[counter] - o_index_arr).empty?   # O  winner?
        return true
      elsif (WIN_COMBINATIONS[counter] - x_index_arr).empty?   # X  winner?
        return true
      end
      counter += 1
    end
  end
end

###########################################################################################################
def full?(board)
  if board.all? { |slot| slot == "X" || slot == "O" }   #returns true for a draw
    return true
  else
    return false
  end
end

###########################################################################################################
def draw?(board)
  if (who_won?(board) == "O won") || (who_won?(board) == "X won")  #returns false for a won game
    return false
  elsif board.all? { |slot| (slot == "X") || (slot == "O") }       #returns true for a draw
    return true
  else
    return false
  end
end

###########################################################################################################
def over?(board)
  if (who_won?(board) == "O won") || (who_won?(board) == "X won")   #returns true for a won game
     return true
  elsif board.all? { |slot| (slot == "X") || (slot == "O") }        #returns true for a draw
    return true
  else
    return false
  end
end

###########################################################################################################
def winner(board)
  if who_won?(board) == "O won"
    return "O"
  elsif who_won?(board) == "X won"
    return "X"
  else
    return nil
  end
end

###########################################################################################################
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

###########################################################################################################
def move(board,position,value = "X")
  position = position.to_i - 1
  board [position] = value
end

###########################################################################################################
def valid_move?(board,position)
  position1 = position.to_i - 1
  if    position_taken?(board,position1) == true || (( 1..8 ) === position1) == false && board[position1] != " " || position1 < 0 || position.to_f != position.to_i  #this got really slopy, new def required
      false
  else  position_taken?(board,position1) == false && position1.between?(2, 8) == true
      true
  end
end

###########################################################################################################
def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.chomp
  if    valid_move?(board,user_input) == true
    move(board,user_input,current_player(board))
    display_board (board)
  else
    puts "that move is not valid"
    turn (board)
  end
end

###########################################################################################################
def turn_count(board)
  turns = 0
  board.each do |turn|
    if  turn == ("X") || turn == ("O")
      turns += 1
    end
  end
  return turns
end
###########################################################################################################
def current_player(board)
  turn = ((turn_count(board)) + 1)
    if (turn % 2) == 0
      return 'O'
    else return 'X'
  end
end
###########################################################################################################


