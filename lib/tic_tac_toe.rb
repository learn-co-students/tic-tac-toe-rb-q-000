require "pry"
WIN_COMBINATIONS = [
[0, 1, 2],
[3, 4, 5],
[6, 7, 8],
[0, 3, 6],
[1, 4, 7],
[2, 5, 8],
[2, 4, 6],
[0, 4, 8],
 ]
 
def display_board(board) 
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board, position, player)
  board[position] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  number = gets.strip
  index = input_to_index(number)
  if (!valid_move?(board, index))
    number = gets.strip
  else
    move(board, index, current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |pos|
  if pos == "X" || pos == "O"  
    count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win|
    if board[win[0]] != " " && board[win[0]] == board[win[1]] && board[win[1]] == board[win[2]] 
     return win
    end
  end
  false
end

def full?(board)
    board.each do |position|
      if position == " "
        return false
      end
    end
    else return true
  end

def draw?(board)
  if full?(board) && ! won?(board)
    return true
  else
    won?(board)
    false
  end
end

  def over?(board)
    if won?(board) || draw?(board)
      return true
    else
    return false
  end
end

def winner(board)
  winning_array = won?(board)
  if winning_array
    return board[winning_array.last]
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
      end
    if winner(board) == "X"
      puts "Congratulations X!"
    elsif winner(board) == "O"
      puts "Congratulations O!"
    else draw?(board)
      puts "Cats Game!"
  end
end