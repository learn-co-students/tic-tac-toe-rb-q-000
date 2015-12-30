def move(board, pos, char="X")
  update_array_at_with(board, pos.to_i - 1, char)
end

def update_array_at_with(board, position, value)
  board[position]=value
end

def valid_move?(board, position)
  pos = position.to_i - 1
  if position_taken?(board, pos)
    return false
  elsif !pos.between?(0,8)
    return false
  else
    return true
  end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, position)
  if board[position] == " " || board[position] == ""
    return false
  elsif !board[position]
    return false
  elsif board[position] == "X" || board[position] == "O"
    return true
  end
end