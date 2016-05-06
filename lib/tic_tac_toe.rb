WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]
def display_board(board)
  print " #{board[0]} ", "|", " #{board[1]} ", "|", " #{board[2]} \n"
  puts "-----------"
  print " #{board[3]} ", "|", " #{board[4]} ", "|", " #{board[5]} \n"
  puts "-----------"
  print " #{board[6]} ", "|", " #{board[7]} ", "|", " #{board[8]} \n"
end

def valid_move?(board, location)
  location = location.to_i - 1
  location.between?(0,8) && !position_taken?(board, location)
end

def position_taken?(board, location)
  
  board[location] != " " && board[location] != ""
end

def move(board, location, token)
  position = location.to_i - 1
  update_array_at_with(board, position, token)
end

def update_array_at_with(array, position, value)
    array[position] = value
end

def turn(board)
  puts "Please enter 1-9:"
  number = gets.strip
  if valid_move?(board, number)
    player = current_player(board)
    move(board, number, player)
    display_board(board)
  else 
    turn(board)
  end
end
   
def turn_count(board)
  counter = 0
  board.each do |b|
    if b == "X" || b == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
    turn_count(board).even? ? "X" : "O"
end

def won?(board)
    win_index1 = WIN_COMBINATIONS[0]
    win_index2 = WIN_COMBINATIONS[1]
    win_index3 = WIN_COMBINATIONS[2]
    win_index4 = WIN_COMBINATIONS[3]
    win_index5 = WIN_COMBINATIONS[4]
    win_index6 = WIN_COMBINATIONS[5]
    win_index7 = WIN_COMBINATIONS[6]
    win_index8 = WIN_COMBINATIONS[7]

    if (board[0] == "X" && board[1] == "X" && board[2] == "X") || (board[0] == "O" && board[1] == "O" && board[2] == "O")
      return win_index1
    elsif (board[3] == "X" && board[4] == "X" && board[5] == "X") || (board[3] == "O" && board[4] == "O" && board[5] == "O")
      return win_index2
    elsif (board[6] == "X" && board[7] == "X" && board[8] == "X") || (board[6] == "O" && board[7] == "O" && board[8] == "O")
      return win_index3
    elsif (board[0] == "X" && board[3] == "X" && board[6] == "X") || (board[0] == "O" && board[3] == "O" && board[6] == "O")
      return win_index4
    elsif (board[1] == "X" && board[4] == "X" && board[7] == "X") || (board[1] == "O" && board[4] == "O" && board[7] == "O")
      return win_index5
    elsif (board[2] == "X" && board[5] == "X" && board[8] == "X") || (board[2] == "O" && board[5] == "O" && board[8] == "O")
      return win_index6
    elsif (board[0] == "X" && board[4] == "X" && board[8] == "X") || (board[0] == "O" && board[4] == "O" && board[8] == "O")
      return win_index7
    elsif (board[2] == "X" && board[4] == "X" && board[6] == "X") || (board[2] == "O" && board[4] == "O" && board[6] == "O")
      return win_index8
    else
      return nil
    end
  end

  def full?(board)
    if board.include?(" ")
      return false
    else
      return true
    end
  end

def draw?(board)
  !won?(board) && full?(board) 
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if  (board[0] == "X" && board[1] == "X" && board[2] == "X") || 
      (board[3] == "X" && board[4] == "X" && board[5] == "X") || 
      (board[6] == "X" && board[7] == "X" && board[8] == "X") || 
      (board[0] == "X" && board[3] == "X" && board[6] == "X") || 
      (board[1] == "X" && board[4] == "X" && board[7] == "X") || 
      (board[2] == "X" && board[5] == "X" && board[8] == "X") || 
      (board[0] == "X" && board[4] == "X" && board[8] == "X") || 
      (board[2] == "X" && board[4] == "X" && board[6] == "X") 
  return "X"

    elsif 
      (board[0] == "O" && board[1] == "O" && board[2] == "O") || 
      (board[3] == "O" && board[4] == "O" && board[5] == "O") || 
      (board[6] == "O" && board[7] == "O" && board[8] == "O") || 
      (board[0] == "O" && board[3] == "O" && board[6] == "O") || 
      (board[1] == "O" && board[4] == "O" && board[7] == "O") || 
      (board[2] == "O" && board[5] == "O" && board[8] == "O") || 
      (board[0] == "O" && board[4] == "O" && board[8] == "O") || 
      (board[2] == "O" && board[4] == "O" && board[6] == "O")
      return "O"
    else
      return nil
    
    end
end

def play(board)
  until over?(board) 
    turn(board)
    draw?(board)
    won?(board)
  end
    if won?(board)
      winner = winner(board)
      puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cats Game!"

  end
end
