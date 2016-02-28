def display_board(board)
  print " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} \n";
end

def winning_combo(board)
  board_status = []
  WIN_COMBINATIONS.each {|combo|
    new_array = Array.new()
    combo.each {|pos|
      new_array.push(board[pos])
      }
    if new_array.length == 3
      board_status.push(new_array)
    end
    if board_status.include?(["X", "X", "X"]) || board_status.include?(["O", "O", "O"])
      return combo
    end
    }
end