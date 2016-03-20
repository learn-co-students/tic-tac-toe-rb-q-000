WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "------------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "------------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, player)
  board[position - 1] = player
end

def position_taken?(board, position)
  if ((board[position] == "X") || (board[position] == "O"))
    return true
  end
  return false
end

def valid_move?(board, position)
  position = position.to_i - 1
  if(( position_taken?(board, position) == false) && (position >= 0) && (position. < 10))
    return true
  end
  return false
end

def turn(board)
  position = gets.chomp.to_i
  if valid_move?(board, position)
    player = current_player(board)
    move(board, (position), player)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  turns = 0
  position = 0
  while (position < board.length)
    if (position_taken?(board, position) == true)
      turns += 1
    end
    position += 1
  end
  return turns
end

def current_player(board)
  if (turn_count(board) % 2 == 0) || (turn_count(board) == 0)
    return "X"
  else
    return "O"
  end
end

def won?(board)
  x = 0
  while (x < WIN_COMBINATIONS.length)
    winning_combo = WIN_COMBINATIONS[x]
    winning_combo1 = winning_combo[0]
    winning_combo2 = winning_combo[1]
    winning_combo3 = winning_combo[2]
    
    if ((board[winning_combo1] == "X") || (board[winning_combo1] == "O")) && ((board[winning_combo1])==(board[winning_combo2])) && ((board[winning_combo3])==(board[winning_combo2]))
      return true
    end
    x += 1
  end
  return false
end

def full?(board)
  x = 0
  while (x < board.length)
    if (board[x] == "") || (board[x] == " ")
      return false
    end
    x += 1
  end
  return true
end
      
def draw?(board)
  if (full?(board) == true) && (won?(board) == false)
    return true
  end
  return false
end

def over?(board)
  if (draw?(board) == true) || (won?(board) == true)
    return true
  end
  return false
end

def winner(board)   
  x = 0
  if (won?(board) == true)
    while (x < WIN_COMBINATIONS.length)
      winning_combo = WIN_COMBINATIONS[x]
      winning_combo1 = winning_combo[0]
      winning_combo2 = winning_combo[1]
      winning_combo3 = winning_combo[2]
        if ((board[winning_combo1])==(board[winning_combo2])) && ((board[winning_combo3])==(board[winning_combo2]))
          if((board[winning_combo1]) == "X" || (board[winning_combo1]) == "O")
              return board[winning_combo1]
          end
        end
      x += 1
    end
  end
  return nil
end

def play(board)
    if (won?(board))
      puts "Congratulations #{winner(board)}!"
      return
    end
    if (draw?(board))
      puts "Cats Game!"
      return
    end
  position = gets.to_i
  player = current_player(board)
  move(board,position, player)
  if (over?(board))
    if (won?(board))
      puts "Congratulations #{winner(board)}!"
      return
    else
      puts "Cats Game!"
      return
    end
  end
  display_board(board)
  play(board)
end



