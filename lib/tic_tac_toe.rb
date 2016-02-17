require_relative "../lib/Tic_Tac_Toe_deffs.rb"

def play (board)

  while over?(board) == false                                    # what's being done every turn
  turn(board)
    if won?(board,win_possibility=WIN_COMBINATIONS) == true          # could shorten and not do below... but would look weird
      break
    elsif draw?(board) == true
      break
    end
  end

    if draw?(board) == true
      return puts "Cats Game!"
    elsif winner(board) == 'X'
      return puts "Congratulations X!"
    elsif winner(board) == 'O'
      return puts "Congratulations O!"
    end
end

# used for testing ...

#board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
#play (board)