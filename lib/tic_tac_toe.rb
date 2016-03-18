WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  ]



board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]



def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end



def move(board, position, char="X")
  board[position.to_i - 1] = char
end



def position_taken?(board, position)
  board[position] != " " && board[position] != "" && board[position] != nil
end



def valid_move?(board, position)
  position = position.to_i - 1
  position_taken?(board, position) == false && position.between?(0,8) == true
end



def turn(board)
  puts 'Please enter 1-9:'
  position = (gets)
  if valid_move?(board, position) && current_player(board) == "X"
    move(board, position, char = "X")
    display_board(board)
  elsif valid_move?(board, position) && current_player(board) == "O"
    move(board, position, char = "O")
    display_board(board)
  else turn(board)
  end
end



def turn_count(board)
player_turns = 0
  board.each do |array_index|
    if array_index == "X" || array_index == "O"
      player_turns += 1
    else
      player_turns += 0
    end
  end
  player_turns
end



def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  elsif turn_count(board) % 2 != 0
    return "O"
  end
end



def won?(board)
  winner = false
  WIN_COMBINATIONS.each do |combination|
    if board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X"
      winner = combination
    elsif board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
      winner = combination
    end
  end
  return winner
end



def full?(board)
  board.all? do |index|
    index == "X" || index == "O"
  end
end



def draw?(board)
  draw = false
  if full?(board) && won?(board) == false
    draw = true
  end
return draw
end


def over?(board)
  over = false
  if full?(board) || won?(board) || draw?(board)
    over = true
  end
return over
end


def winner(board)
  winning_player = nil
  WIN_COMBINATIONS.each do |combination|
    if board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X"
      winning_player = "X"
    elsif board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
      winning_player = "O"
    end
  end
  return winning_player
end

def play(board)
  while won?(board) == false && full?(board) == false && draw?(board) == false && over?(board) == false
    turn(board)
  end
  if draw?(board) == true
    puts "Cats Game!"
  end
  if won?(board) && winner(board) == "X"
    puts "Congratulations X!"
  elsif won?(board) && winner(board) == "O"
    puts "Congratulations O!"
  end
end