WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]]

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "

end

def move(array,position, choice = "X")
  position = position.to_i
  array[position-1] = choice
  display_board(array)
end


def valid_move?(board,position)
  position = position.to_i
  position = position -1
  if position_taken?(board,position) == false && position.between?(0,8)
    true
  else
    false
  end
end#

def turn_count(array)
  counter = 0
  array.each do |x|
    if x == "X" || x == "O"
      counter +=1
    end
    end
  return counter
end

def current_player(array)
  turn = turn_count(array)
  a = "X"
  b = "O"
  if turn == 0
    a
  elsif turn % 2 != 0
    b
  elsif turn % 2 == 0
    a
  end
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]]

def won?(board)
  clear = board.all? do |x|
    x == " "
  end
    if clear == true
      return false
    end


  counter = 0

  WIN_COMBINATIONS.each do |win_combinations|

    win_index_1 = win_combinations[0]
    win_index_2 = win_combinations[1]
    win_index_3 = win_combinations[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    counter += 1
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combinations
      break# return the win_combination indexes that won.
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combinations
      break
    else
      nil
    end
  end

  if counter == 9
    return false
  end
end

def full?(board)
  if board.include?(" ")
    return false
  else
    return true
  end
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board) == false && won?(board) != true
    return false
  else
    return true

  end
end

def over?(board)
  if draw?(board)
    return true
  elsif won?(board)
    return true
  else
    return false

  end
end

def winner(board)
  var = won?(board)
  if won?(board)
    if board[var[0]] == "X"
      return "X"
    elsif board[var[0]] == "O"
      return "O"
    else
      nil
    end
  end
end


def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    peg = current_player(board)
    if valid_move?(board,input) == false
      puts "Sorry that input wasn't acceptable."
      turn(board)
    else
      puts input
      move(board,input,peg)
      #puts "#{current_player(board)}"
    end
  if won?(board)
    return "Congratulations #{winner(board)}"
  elsif draw?(board)
    print "Cats Game!"
  else
    nil
  end

end

def play(board)
  while over?(board) == false
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  elsif winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else
    nil
end
end

