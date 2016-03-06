# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [6,4,2], [0,4,8]]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Define your play method below
def play(board)

  #ready = gets


  #turn_counter = 0

  until over?(board) #turn_counter < 9

    turn(board)
   # turn_counter += 1
     #if over?(board)

    if cats_game?(board)
       puts "Cat's Game!"
       return
    end
    if won?(board)
     if winner?(board) == "X"
       puts "Congratulations X!"
     else
       puts "Congratulations O!"
     end
     return
    end

   #end
   end
end

def turn(board)
  puts "#{current_player(turn_count(board))} is the current player"
  puts "Please enter 1-9:"
  input = gets
  if valid_move?(board, input)
    move(board, input, current_player(turn_count(board)))
  else
    turn(board)
  end
  display_board(board)
end


def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn_count(board)
  counter=0
board.each do |space|
  if space == "X" || space == "O"
    counter += 1
  end
end
return counter
end

def current_player(numoturns)
    return numoturns % 2 == 0  ? "X" : "O"
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def won?(board)
  WIN_COMBINATIONS.each do |subarray|
    if board[subarray[0]] == "X" && board[subarray[1]] == "X" && board[subarray[2]] == "X"
      #puts "X is the winner"
      #return subarray
      return true
    end

    if board[subarray[0]] == "O" && board[subarray[1]] == "O" && board[subarray[2]] == "O"
     # puts "O is the winner"
     #return subarray
      return true
    end
  end
  return nil
end

def full?(board)
    board.each do |element|
      if element == "" || element == " "
        return false
      end
    end
    return true
end

def draw?(board)
   if full?(board) && !won?(board)
     return true
   end
   return false
end

def over?(board)
   if full?(board) || won?(board) || draw?(board) || cats_game?(board)
     return true
   end
   return false
end

def winner?(board)
  WIN_COMBINATIONS.each do |subarray|
    if board[subarray[0]] == "X" && board[subarray[1]] == "X" && board[subarray[2]] == "X"
      #puts "X is the winner"
      return "X"
    end

    if board[subarray[0]] == "O" && board[subarray[1]] == "O" && board[subarray[2]] == "O"
     # puts "O is the winner"
      return "O"
    end
  end
  return nil
end

def has_x?(board,subarray)
  subarray.each do |element|
    if board[element] == "X"
      return true
    end
  end
return false
end

def has_o?(board,subarray)
  subarray.each do |element|
    if board[element] == "O"
      return true
    end
  end
return false
end

def x_and_o?(board,subarray)
  subarray.each do |element|
    if has_x?(board,subarray) && has_o?(board,subarray)
      return true
    else
      return false
    end
  end
end


def turn_count(board)
  counter=0
board.each do |space|
  if space == "X" || space == "O"
    counter += 1
  end
end
return counter
end

def cats_game?(board)
  if turn_count(board) < 7
    return false
  end
  WIN_COMBINATIONS.each do |subarray|
    if !x_and_o?(board,subarray)
       return false
    end
  end
  return true
end
