WIN_COMBINATIONS =[
                    [0,1,2],
                    [3,4,5],
                    [6,7,8],
                    [0,3,6],
                    [1,4,7],
                    [2,5,8],
                    [0,4,8],
                    [2,4,6],
                  ]

def display_board(board)
  puts " #{board[0]} " + "|" +  " #{board[1]} " + "|" +  " #{board[2]} "

  puts "-----------"

  puts " #{board[3]} " + "|" +  " #{board[4]} " + "|" +  " #{board[5]} "

  puts "-----------"

  puts " #{board[6]} " + "|" +  " #{board[7]} " + "|" +  " #{board[8]} "
end

def move(board, input, player="X")
  input=input.to_i
  input=input-1
  board[input]=player
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end
def valid_move?(board, position)
    position = position.to_i-1
  if  position.between?(0,8) && position_taken?(board, position)==false
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def won?(board)
    WIN_COMBINATIONS.each do |arr|
        if board[arr[0]] == "X" && board[arr[1]] == "X" && board[arr[2]] == "X" ||
            board[arr[0]] == "O" && board[arr[1]] == "O" && board[arr[2]] == "O"
            return arr # return the win_combination indexes that won.
        end
    end
  false
end

def full?(board)
   board.all? do |space|
    space!=" "
   end
end

def draw?(board)
  if  full?(board) &&  !won?(board)
    true
  end
end

def over?(board)
  if won?(board) || draw?(board) 
    return true
  else
    return false
  end
end

def winner(board)
  arr = won?(board)
  if arr!=false
    return board[arr[0]]
  end
end

def turn_count(board)
  count=0
  board.each do |space|
    if space =="X" || space=="O"
      count+=1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2==0
    return "X"
  else
    return "O"
  end
end






def play(board)
  until over?(board) do
    turn(board)
    draw?(board)
    winner(board)
  end
  
  if won?(board)
    w = winner(board)
    puts "Congratulations #{w}!"
  else
    puts "Cats Game!"
  end
end












