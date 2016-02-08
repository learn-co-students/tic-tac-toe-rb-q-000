#require 'pry'
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, token="X")
  position = position.to_i - 1
  #binding.pry
  board[position] = token
  #binding.pry
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board,position)
  position = position.to_i - 1
  if position.between?(0,8) == true
    if position_taken?(board, position) == true
      return false
    end
    return true
  end
end

def turn(board)
  #binding.pry
  player_up = current_player(board)
  puts "Player #{player_up}, Please enter 1-9:"
  userEntry = gets.chomp
  #binding.pry
  if valid_move?(board,userEntry) == true
    #binding.pry
    move(board,userEntry,player_up)
    display_board(board)
    #binding.pry
#     if over?(board) == true
#       return
#     end
  else
    puts "Entry not valid. Try again"
    #binding.pry
    turn(board)
    #binding.pry
  end
end

def turn_count(board)
  counter = 0
  board.each do |cell|
    if cell != " "
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board).odd? == true ? "O" : "X"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      puts "Congratulations X!"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      puts "Congratulations O!"
      return win_combination
#     elsif draw?(board) == true
#       puts "Cats Game!"
#       return false
    end
  end
  return false
end

def empty?(board)
  #binding.pry
  empty = board.all? do |cell|
    cell == " "
  end
  return empty
  #binding.pry
end

def full?(board)
  #binding.pry
  full = board.none? do |cell|
    cell == " "
  end
  return full
  #binding.pry
end

def draw?(board)
  #binding.pry
  if full?(board) == true && won?(board) == false
    return true
  elsif full?(board) == false
    return false
  elsif full?(board) == true && won?(board) != false
    return false
  end
  #binding.pry
end

def over?(board)
  #binding.pry
  if won?(board) != false
    return true
  elsif draw?(board) == true
    return true
  elsif full?(board) == true
    return true
  else
    return false
  end
  #binding.pry
end

def winner(board)
  winning_combo = won?(board)
  if winning_combo == false
    return nil
  end
  winning_index = winning_combo[0]
  if board[winning_index] == "X"
    return "X"
  elsif board[winning_index] == "O"
    return "O"
  end
end

def play(board)
  until over?(board) == true do
    #binding.pry
    turn(board)
    #binding.pry
  end
  if draw?(board) == true
    return puts "Cats Game!"
  end
end
