
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def input_to_index(input)
  return (input.to_i)-1
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board,index,character)
    board[index] = character
end

def position_taken?(board, index)
  if (board[index] == " " || board[index] == "" || board[index] == nil)
    return false
  else
  return true
  end
end

def valid_move?(board, index)

    if (!position_taken?(board, index) && ((index>-1) && (index<9)))
        return true
    else
      return false
    end
end

def turn(board)
  puts "Please enter 1-9:"
  number = input_to_index(gets.strip)
  until valid_move?(board, number)
    puts "Error. Please enter from 1-9:"
    number = input_to_index(gets.strip)
    valid_move?(board, number)
  end
  if (turn_count(board) % 2 == 0)
    move(board, number, "X")
  else
    move(board, number, "O")
  end
  display_board(board)
end

def turn_count(board)
  i = 0
  counter = 0
  while i < board.size
    if (board[i] != " ")
      counter += 1
      i += 1
    else
      i +=1
    end
  end
  return counter
end

def current_player(board)
  turns = turn_count(board)
  if turns == 0
    return "X"
  elsif (turns % 2 == 0)
    return "X"
  else
    return "O"
  end
end

def won?(board)

  if (!position_taken?(board,0) && !position_taken?(board,1) &&
      !position_taken?(board,2) && !position_taken?(board,3) &&
      !position_taken?(board,4) && !position_taken?(board,5) &&
      !position_taken?(board,6) && !position_taken?(board,7) &&
      !position_taken?(board,8))
        return nil
      end

  win_index_1 = WIN_COMBINATIONS[0]
  win_index_2 = WIN_COMBINATIONS[1]
  win_index_3 = WIN_COMBINATIONS[2]
  win_index_4 = WIN_COMBINATIONS[3]
  win_index_5 = WIN_COMBINATIONS[4]
  win_index_6 = WIN_COMBINATIONS[5]
  win_index_7 = WIN_COMBINATIONS[6]
  win_index_8 = WIN_COMBINATIONS[7]

  if (board[win_index_1[0]] == "O" && board[win_index_1[1]] == "O" && board[win_index_1[2]] == "O")
      return win_index_1

  elsif (board[win_index_1[0]] == "X" && board[win_index_1[1]] == "X" && board[win_index_1[2]] == "X")
      return win_index_1

  elsif (board[win_index_2[0]] == "O" && board[win_index_2[1]] == "O" && board[win_index_2[2]] == "O")
      return win_index_2

  elsif (board[win_index_2[0]] == "X" && board[win_index_2[1]] == "X" && board[win_index_2[2]] == "X")
      return win_index_2

  elsif (board[win_index_3[0]] == "O" && board[win_index_3[1]] == "O" && board[win_index_3[2]] == "O")
      return win_index_3

  elsif (board[win_index_3[0]] == "X" && board[win_index_3[1]] == "X" && board[win_index_3[2]] == "X")
      return win_index_3

  elsif (board[win_index_4[0]] == "O" && board[win_index_4[1]] == "O" && board[win_index_4[2]] == "O")
      return win_index_4

  elsif (board[win_index_4[0]] == "X" && board[win_index_4[1]] == "X" && board[win_index_4[2]] == "X")
      return win_index_4

  elsif (board[win_index_5[0]] == "O" && board[win_index_5[1]] == "O" && board[win_index_5[2]] == "O")
      return win_index_5

  elsif (board[win_index_5[0]] == "X" && board[win_index_5[1]] == "X" && board[win_index_5[2]] == "X")
      return win_index_5

  elsif (board[win_index_6[0]] == "O" && board[win_index_6[1]] == "O" && board[win_index_6[2]] == "O")
      return win_index_6

  elsif (board[win_index_6[0]] == "X" && board[win_index_6[1]] == "X" && board[win_index_6[2]] == "X")
      return win_index_6

  elsif (board[win_index_7[0]] == "O" && board[win_index_7[1]] == "O" && board[win_index_7[2]] == "O")
      return win_index_7

  elsif (board[win_index_7[0]] == "X" && board[win_index_7[1]] == "X" && board[win_index_7[2]] == "X")
      return win_index_7

  elsif (board[win_index_8[0]] == "O" && board[win_index_8[1]] == "O" && board[win_index_8[2]] == "O")
      return win_index_8

  elsif (board[win_index_8[0]] == "X" && board[win_index_8[1]] == "X" && board[win_index_8[2]] == "X")
      return win_index_8

  else
    return nil
  end
end

def full?(board)
  if (board[0] != " " && board[1] != " " && board[2] != " " && board[3] != " " &&
      board[4] != " " && board[5] != " " && board[6] != " " && board[7] != " " &&
      board[8] != " ")
        return true
  else
    return false
  end
end

def draw?(board)
  if won?(board) != nil
    return false
  elsif full?(board) == true
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) == true
    return true
  elsif full?(board) == false
    return false
  elsif won?(board) != nil
    return true
  end
end

def winner(board)
  if won?(board) == nil
    return nil
  else
    return board[won?(board)[0]]
  end
end

def play(board)

  until over?(board)
  turn(board)
  end

  if won?(board) != nil
    puts "Congratulations"
  else
    puts "Game was a draw"
  end
end
