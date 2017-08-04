WIN_COMBINATIONS = [[0,1,2],[0,3,6],[0,4,8],[1,4,7],[2,4,6],[2,5,8],[3,4,5],[6,7,8]]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
user_input.to_i - 1
end

def move(board, index, value)
board[index] = value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0,8) && !position_taken?(board, index)
    return true
  else return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  until valid_move?(board,index) == true do
    puts "Try again. Where would you like to move?"
    user_input = gets.strip
    index = input_to_index(user_input)
  end
  move(board,index,current_player(board))
end

def turn_count(board)
  turnz = 0

  board.each do |index|
    if index == "X" || index == "O"
      turnz += 1
    end
  end
  return turnz
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  elsif turn_count(board) % 2 != 0
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |index|
    win_index_1 = index[0]
    win_index_2 = index[1]
    win_index_3 = index[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if position_taken?(board, win_index_1)
      if position_1 == position_2 && position_2 == position_3
        return true
      end
    end
  end
  return false
end

def full?(board)
  counter = 0
  board.each do |index|
    if index == "X" || index == "O"
      counter += 1
    end
    if counter >= 8
      return true
    end
  end
  return false
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else return false
  end
end

def over?(board)
  if draw?(board) || won?(board) || full?(board)
    return true
  else return false
  end
end

def winner(board)
  WIN_COMBINATIONS.each do |index|
    win_index_1 = index[0]
    win_index_2 = index[1]
    win_index_3 = index[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if position_taken?(board, win_index_1)
      if position_1 == position_2 && position_2 == position_3
        return "#{board[win_index_1]}"
      end
    end
  end
  return nil
end

def play(board)
  until over?(board) do
    turn(board)
    display_board(board)
  end
  if won?(board) == false && draw?(board)
    puts "Cats Game!"
  elsif won?(board).class
    puts "Congratulations #{winner(board)}!"
  end
end
