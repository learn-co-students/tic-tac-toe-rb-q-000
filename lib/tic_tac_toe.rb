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

def display_board(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])
  seperator = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts seperator
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts seperator
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(array, input, char = "X")
  array[input.to_i - 1] = char
end

def position_taken?(board, position)
  if position < 0 || position > 9
    return nil
  elsif board[position] == "" || board[position] == " " || board[position] == "  "
    return false
  elsif board[position] == "X" || board[position] = "O"
    return true
  end
end

def valid_move?(board, position)
  realPosition = position.to_i - 1
  if position_taken?(board, realPosition) == true || position_taken?(board, realPosition) == nil
    return false
  else
   return true
  end
end

def turn(board)
  input = gets.strip
  until valid_move?(board, input)
    puts "Invalid entry."
    display_board(board)
    input = gets.strip
  end
  move(board, input, current_player(board))
  display_board(board)   
end

def turn_count(board)
  turnCount = 0
  board.each do |spot|
    if spot == "X" || spot == "O"
        turnCount += 1
    end
  end
  return turnCount
end

def current_player(board)
  turnCount = turn_count(board)
  if turnCount % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  if WIN_COMBINATIONS.none? do |streak|
        (board[streak[0]] == "X" && board[streak[1]] == "X" && board[streak[2]] == "X") || (board[streak[0]] == "O" && board[streak[1]] == "O" && board[streak[2]] == "O")
    end
  return false
  else WIN_COMBINATIONS.each do |streak|
      if (board[streak[0]] == "X" && board[streak[1]] == "X" && board[streak[2]] == "X") || (board[streak[0]] == "O" && board[streak[1]] == "O" && board[streak[2]] == "O")
        return streak
      end
    end
  end
end

def full?(board)
  if board.all? do |spot|
    spot == "X" || spot == "O"
    end
    return true
  else
    return false
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) != false || full?(board) == true || draw?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) == false 
    return nil
  else WIN_COMBINATIONS.each do |streak|
      if (board[streak[0]] == "X" && board[streak[1]] == "X" && board[streak[2]] == "X")
        return "X"
      elsif (board[streak[0]] == "O" && board[streak[1]] == "O" && board[streak[2]] == "O")
        return "O"
      end
    end
  end
end

def play(board)
    until over?(board) == true
        display_board(board)
        turn(board)
    end
    puts "Thank you for playing!"
    if won?(board) != false
      puts "Congratulations #{winner(board)}!"
    else
      puts "Cats Game!"
    end
end
