def draw?(board)
  board_status = []
  WIN_COMBINATIONS.each {|combo|
    new_array = Array.new()
    combo.each {|pos|
      new_array.push(board[pos])
      }
    if new_array.length == 3
      board_status.push(new_array)
    end
    }
  if board_status.include?(["X", "X", "X"]) || board_status.include?(["O", "O", "O"])
    false
  else
    true
  end
end

def full?(board)
  if board.any? {|pos| pos == " "} == false
    draw?(board)
  else
    false
  end
end