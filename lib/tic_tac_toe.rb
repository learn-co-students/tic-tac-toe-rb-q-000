require 'pry'
WIN_COMBINATIONS = [
    [0,1,2], [3,4,5], [6,7,8],  # horizontal
    [0,3,6], [1,4,7], [2,5,8],  # vertical
    [0,4,8], [2,4,6]            # diagonal
]


def display_board(board)
    if board == nil
      return
    end
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def move(board,position,char)
  position = position.to_i - 1
  board[position] = char
  return board
end


def position_taken?(board, position)
  if board[position] == " " || board[position] == nil || board[position] == ""
    return false
  elsif board[position] == "X" || board[position] == "O"
    return true
  else 
    return true
  end
end


def valid_move?(board,position)
  position = position.to_i - 1
  position_taken = position_taken?(board, position)
  if position > 8 || position_taken == true || position < 0
    return false
  elsif position < 9 && position_taken == false # NIL here!!
    return true
  end
end


def turn(board)
  
  player = current_player(board)
  puts "Please enter 1-9:"
  position = gets
  if valid_move?(board, position)
    move(board, position, player)
    display_board(board)
  else
    turn(board)
  end
end


def turn_count(board) 
# how many turns already done
  num = 0
  board.each do |index|
    if index == "X" || index == "O"
      num += 1
    end
  end
  return num
end


def current_player(board) 
# how’s turn it is now
  num = turn_count(board)
  if num.even? || board == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    return "X"
  else 
    return "O"
  end
end


def won?(board)
  if board == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    return false
  end 
  WIN_COMBINATIONS.each do |win_comb|
    a = win_comb[0]
    b = win_comb[1]
    c = win_comb[2]
    position_a = board[a]
    position_b = board[b]
    position_c = board[c]
    if position_a == "X" && position_b == "X" && position_c == "X"
      return win_comb
    elsif position_a == "O" && position_b == "O" && position_c == "O"
      return win_comb
    end
  end
  return false
end


def full?(board)
  !board.include?(" ")
end


def draw?(board)
  !won?(board) && full?(board)
end


def over?(board)
  full?(board) || won?(board)
end


def winner(board)
  if won?(board) == false
    return nil
  else
    win_comb = won?(board)
    return "#{board[win_comb[0]]}"
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
    return
  end
end