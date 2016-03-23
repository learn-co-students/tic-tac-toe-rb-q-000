WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

def display_board(board = [])
  puts  " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]}  "
  puts  "-----------"
  puts  " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]}  "
  puts  "-----------"
  puts  " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]}  "
end
def move(board, position, character = "X")
  board[position.to_i - 1] = character
end

def position_taken?(board, position)
  if  board[position] == "X" || board[position] == "O" || board[position] == "x" || board[position] == "o"
    return true
  else
    return false
  end
end

def valid_move?(board, position)
  if position_taken?(board, (position.to_i - 1)) == true || position.to_i.between?(1, 9) == false
    return nil
  else
    return true
  end
end

def turn_count(board)
    counter = 0
    board.each{|element| counter += 1 if element == "X" || element == "O"}
    return counter
end

def current_player(board)
  if turn_count(board).even? == true
    return "X"
    else
    return "O"
  end
end

def won?(board)
        return WIN_COMBINATIONS.any? do |combo|
        if
        board[combo[0]] + board[combo[1]] + board[combo[2]] == "XXX" || board[combo[0]] + board[combo[1]] + board[combo[2]] == "OOO"
        return combo
        end
        end
end

def full?(board)
    return board.all?{|element| element == "X" || element == "O"}
end

def draw?(board)
    if full?(board) == true &&  won?(board) == false
        return true
    else
        return false
    end
end

def over?(board)
    if draw?(board) == true || full?(board) == true
        return true
    else
        return false
    end
end

def winner(board)
   if  won?(board) != false
        return board[won?(board)[0]]
   end
    return nil
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  character = current_player(board)
 if valid_move?(board, input) == true
      move(board, input.to_i, character)
      display_board(board)
    else
      turn(board)
 end
end

def play(board)
  while over?(board) == false &&  won?(board) == false
     turn(board)
  end
  if won?(board) != true
     puts "Congratulations #{winner(board)}!"
  end
     puts "Cats Game!"
end

