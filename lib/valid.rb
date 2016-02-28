def move(board, pos, player="X")
  board_pos = pos.to_i - 1;
  board[board_pos] = player;
  puts display_board(board);
  return board
end

def valid_move?(board, pos)
  position = pos.to_i
  if position <= 9 && position > 0
    if "#{true if board[position - 1] == "X" || board[position - 1] == "O"}" == "true"
      false
    else
      true
    end
  else
    false
  end
end

def position_taken?(board, position)
  if board[position.to_i] == " " || board[position.to_i] == nil || board[position.to_i].length == 0
    false
  else
    true
  end
end

def turn_count(board)
  turns_taken = 0
  board.each {|space|
    if space == "X" || space == "O"
      turns_taken += 1
    end
    }
  return turns_taken
end
def current_player(board)
  players_turn = 9 - turn_count(board)
  if players_turn % 2 == 0
    return "O"
  else
    return "X"
  end
end

def turn(board)
  puts "Please enter a move 1-9!"
  player_choice = gets.strip
  if valid_move?(board, player_choice)
    move(board, player_choice, current_player(board))
  else
    puts "You have selected an invalid move, please try agian."
    turn(board)
  end
end

