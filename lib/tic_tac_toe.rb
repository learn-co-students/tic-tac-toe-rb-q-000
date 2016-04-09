board = [" "," "," "," "," "," "," "," "," "]
require 'pry'

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board,position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    return false
  elsif board[position] == "X" || board[position] == "O"
    return true
  end
end

def valid_move?(arr,pos)
  pos = pos.to_i
  pos = pos - 1
  if position_taken?(arr,pos) == false && pos.between?(0,8)
    return true
  else
    return nil
  end
end

def move(board,position,current_player)
  position = position.to_i - 1
  board[position] = current_player
end

def turn_count(board)
  counter = 0
  board.each do |x|
    if x == "X" || x == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

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


def won? (board)
  WIN_COMBINATIONS.each do |level_one|
      windex1 = level_one[0]
      windex2 = level_one[1]
      windex3 = level_one[2]
      pos_1 = board[windex1]
      pos_2 = board[windex2]
      pos_3 = board[windex3]
      new_array = []
      if pos_1 == "X" && pos_2 == "X" && pos_3 == "X"
        new_array = new_array.push(level_one[0],level_one[1],level_one[2])
        return new_array
      elsif pos_1 == "O" && pos_2 == "O" && pos_3 == "O"
        new_array = new_array.push(level_one[0],level_one[1],level_one[2])
        return new_array
      end
    end
    return false
end

def full? (board)
  board.each do |x|
    if x == " " || x == "" || x == nil
      return false
    end
  end
  return true
end


def draw? (board)
  if !(won?(board)) && full?(board)  
    return true
  elsif !(won?(board)) && !(full?(board))
    return false
  elsif won?(board)
    return false
  end
end

def winner(board)
  if won?(board)
    champ = won?(board)[0]
    return board[champ]
  end
end

def over? (board)
  if won?(board) || draw?(board)
    return true
  end
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
    if valid_move?(board,input)# == true
      move(board,input,current_player(board))# added the current_player(board) to args
      display_board(board)
    else
      turn(board)
    end
end

# def play(board)
#   binding.pry
# end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    return nil
  else
    puts "Cats Game!"
    return nil
  end
end

# def play(board)
#   input = gets
# end


