WIN_COMBINATIONS = [
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right column
  [0,4,8],  # Down-right diagonal
  [2,4,6]   # Down-left diagonal
  ]

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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def current_player(board)
  return turn_count(board)%2 == 0 ? "X" : "O"
end

def won?(board)
  ["X","O"].each do |token|
    WIN_COMBINATIONS.each do |win_combination|
      @all_same = win_combination.all? do |index|
        board[index] == token
      end
      if @all_same
        return win_combination 
      end
    end
  end
  return @all_same
end

def full?(board)
  board.each_with_index do |pos, i|
    if !position_taken?(board, i)
      return false
    end
  end
end

def draw?(board)
  return !won?(board) && full?(board) ? true : false
end

def over?(board)
  return won?(board) || draw?(board) || full?(board) ? true : false
end

def winner(board)
  return won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else if draw?(board)
    puts "Cats Game!"
  end
  end
end