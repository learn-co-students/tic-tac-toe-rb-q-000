def draw?(board)
  !won?(board) && full?(board)
end

def full?(board)
  board.all?{ |token| token == 'X' || token == 'O' }
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  position = won?(board)
  if won?(board) == false
    nil
  elsif board[position[0]] == 'X' && board[position[1]] == 'X' && board[position[2]] == 'X'
    'X'
  elsif board[position[0]] == 'O' && board[position[1]] == 'O' && board[position[2]] == 'O'
    'O'
  end
end
