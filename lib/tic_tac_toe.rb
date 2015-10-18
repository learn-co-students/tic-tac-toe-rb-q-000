def display_board(board)
  puts "A Tic Tac Toe Board"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board,position,char="X")

  board[position.to_i-1]=char
  return board
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input,current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def play(board)

  turn_counter=0
  while turn_counter < 9
    
    if won?(board)
      puts "Congratulations #{winner(board)}!"
      break
    end
    if over?(board)
      break
    end
    turn(board)
    turn_counter += 1
  end

end

def turn_count(board)
  turncounter = 0
  board.each do |x|
    if x == "X" || x == "O"
      turncounter += 1
    end
  end
  return turncounter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row

  [0,3,6],  # First column
  [1,4,7],  # Second column
  [2,5,8],  # Third column

  [0,4,8],  # First Diagonal
  [6,4,2]  # Second Diagonal
]

def won?(board)

  board.any?{|cell| cell == " "}

  WIN_COMBINATIONS.each do |combination|
    if position_taken?(board, combination[0]) && position_taken?(board, combination[1]) && position_taken?(board, combination[2])
      if board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]] && board[combination[0]] == board[combination[2]]
        return combination
      end
    end
  end

  return false

end

def full?(board)
  if won?(board) == false && !board.any?{|cell| cell == " "}
    return true
  else
    return false
  end
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    puts "Cats Game!"
    return true
  else
    false
  end
end

def over?(board)
  if draw?(board)
    true
  elsif won?(board)
    true
  else
    false
  end

end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end
