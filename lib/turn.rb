def position_on_board?(board, position)
  if (position - 1) <= board.count
    true
  else
    false
  end
end

