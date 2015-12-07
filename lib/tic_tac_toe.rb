WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8],
  [0,4,8], [0,3,6], [1,4,7],
  [2,4,6], [2,5,8]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, position)
  return false if position =~ /(\D|\s)/
  position = position.to_i - 1
  if (board[position] == " " || board[position] == "" || board[position] == nil)
    return true
  else
    return false
  end
end

def position_taken?(board, position)
  if (board[position] == " " || board[position] == "" || board[position] == nil)
    return false
  end
  return true
end

def move(board,position,xoro="X")
  board[position.to_i - 1] = xoro
end

def turn(board)
  puts "Please enter 1-9:"
  choice = gets.chomp
  valid = valid_move?(board,choice)
  if valid == false
    puts "Invalid input.  Please try that again!"
    choice = gets.chomp
    move(board,choice,current_player(board))
    display_board(board)
  else
    move(board,choice,current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  board.select{|element| (element == "X" || element == "O")}.count
end

def current_player(board)
  board.count{|token| token == "X"} > board.count{|token| token == "O"} ? "O" : "X"
end

def full?(board)
  board.include?(" ") ? false : true
end

def draw?(board)
  return false if won?(board)
  return true if full?(board)
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = board[win_combination[0]]
    position_2 = board[win_combination[1]]
    position_3 = board[win_combination[2]]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  #if no win_combination has been returned, it's a blank board or a draw.
  return false
end

def over?(board)
  if (won?(board) || draw?(board))
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    winner = won?(board)
    winner = board[winner[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end

  if draw?(board)
    puts "Cats Game!"
  end


end
