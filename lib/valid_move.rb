def valid_move?(board, position)
  if position == 'invalid'
    false
  else
    position = position.to_i - 1
    if position_on_board?(board, position) && !occupied?(board, position)
      true
    else
      false
    end
  end
end

def invalid_string(position)
  position.size > 1
end

def position_on_board?(board, position)
  if position <= board.count
    true
  else
    false
  end
end

def occupied?(board, position)
  if board[position].include?("X") || board[position].include?("O")
    true
  else
    false
  end
end
