WIN_COMBINATIONS =  [ #Horizontal 
                      [0,1,2],
                      [3,4,5],
                      [6,7,8],
                      #Vertical
                      [0,3,6],
                      [1,4,7],
                      [2,5,8],
                      #Diagonal
                      [0,4,8],
                      [6,4,2]
                    ]

def display_board(board = [" "," "," "," "," "," "," "," "," "])
    puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n"+
         " #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n"+
         " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char=current_player(board))
  board[position.to_i-1] = char
end

def position_taken?(board, position)
  if (board[position.to_i] == "X") || (board[position.to_i] == "O")
    return true
  else
    return false
  end 
end

def valid_move?(board, position)
  if position.to_i.between?(1, 9) != true
    return false
  elsif position_taken?(board, (position.to_i-1))
    return false
  else board[position.to_i-1] == " "
    return true
  end
end

def turn(board)
puts "Please enter 1-9:"
input = gets.strip

  if valid_move?(board, input)
    move(board, input)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |char|
    if char == "X" || char == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    xo1 = win_combination[0]
    xo2 = win_combination[1]
    xo3 = win_combination[2]

    if (board[xo1] == "X" && board[xo2] == "X" && board[xo3] == "X") ||
       (board[xo1] == "O" && board[xo2] == "O" && board[xo3] == "O")
       return win_combination
    end
  end
  return false
end

def full?(board) 
  x = board.all? { |value| value != " " }
  return x
end

def draw?(board)
  if !!(full?(board)) &&  !(won?(board))
    return true
  end
end

def over?(board)
  if  (draw?(board) == true || won?(board) != false)
    return true
  end
end 

def winner(board)
  if won?(board) != false
    x = won?(board)[0]
    return board[x]
  end
end

def play(board)
  while over?(board) != true
    turn(board)
  end
  if draw?(board) == true
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end