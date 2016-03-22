WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

display_board(board)
display_board(board)
display_board(board)

def move (board, pos, char = "X")
  pos = pos.to_i - 1
  board[pos] = char
end

def position_taken?(board, pos)
  if board[pos] == " "
    return false
    else
    return true
  end
end

def valid_move?(board, pos)
  pos.to_i.between?(1,9) && !position_taken?(board, pos.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, char = current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) == 0
    return "X"
    elsif turn_count(board) % 2 && turn_count(board).to_i.even?
    return "X"
    else
    return "O"
  end
end

def won?(board)
    WIN_COMBINATIONS.each do |combo|
  win_1 = combo[0]
  win_2 = combo[1]
  win_3 = combo[2]

  pos_1 = board[win_1]
  pos_2 = board[win_2]
  pos_3 = board[win_3]

    if (pos_1 == "X" && pos_2 == "X" && pos_3 == "X") || (pos_1 == "O" && pos_2 == "O" && pos_3 == "O")
    return combo
    end
 end
  return false
end

def full?(board)
  board.each do |spot|
    if spot.nil? || spot == " "
      return false
    end
  end
  return true
end

def draw?(board)
  if full?(board) && !won?(board)
        true
  end
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
      true
  end
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
    puts "Cats Game!"
  end
end

