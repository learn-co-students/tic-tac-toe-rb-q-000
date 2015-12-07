
WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8],
  [0,4,8], [6,4,2]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, character = "X")
  board[position.to_i - 1] = character
end
def position_taken?(board, position)

  if board[position] == " " || board[position] == "" || board[position] == nil
    return false
  elsif board[position] == "X" || board[position] == "O"
    return true
  end
end

def valid_move?(board, position)
  current_move = position.to_i - 1

  if !position_taken?(board, current_move) && current_move.between?(0, 8)
    return true
  else
    false
  end
end
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
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
    counter
   end
  end
  counter
end
def current_player(board)
  if turn_count(board) % 2 == 0
  return "X"
  else
    return "O"
end
end
def won?(board)

  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"

  return win_combination
    else
      false
    end
  end
end

def full?(board)
  board.all? do |square|
    square == "X" || square == "O"
    end
end
def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
end
def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end
def winner(board)
  if won?(board) # if game is won
    won?(board).each do |t| # for each element in the winning array
      return board[t]
    end
  end
end
def play(board)
  until over?(board)
  turn(board)

  end

  if won?(board)
    if winner(board)

the_winner = winner(board)
      puts "Congratulations #{the_winner}!"
    end
  elsif draw?(board)
    puts "Cats Game!"
  end
def play
  until over?
  turn
  end
  if won?
    if winner

the_winner = winner
      puts "Congratulations #{the_winner}!"
    end
  elsif draw?
    puts "Cats Game!"
  end
end
end