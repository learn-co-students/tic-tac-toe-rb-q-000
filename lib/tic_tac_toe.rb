require_relative 'draw_game.rb'
require_relative 'valid.rb'
require_relative 'winningCombo_&_displayBoard.rb'

WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def won?(board)
  if board == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    false
  elsif draw?(board)
    false
  else
    winning_combo(board)
  end
end

def over?(board)
  if won?(board).class == Array
    true
  elsif full?(board) == false
    false
  else
    true
  end
end

def winner(board)
  if won?(board).class == Array
    player_won = won?(board)
    board[player_won[0]]
  else
    nil
  end
end

def play(board)
  display_board(board)
  stop = false
  while !(stop)
    if full?(board)
      puts "Cats Game!"
      stop = true
    elsif over?(board)
      puts "Congratulations #{winner(board)}!"
      stop = true
    else
      turn(board)
    end
  end
end

