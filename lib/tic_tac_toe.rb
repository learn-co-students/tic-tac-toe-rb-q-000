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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(array, position, char = "X")
  array[(position.to_i - 1)] = char
end

def position_taken?(board, position)
  if board[position.to_i] == " " || board[position.to_i] == "" || board[position.to_i] == nil
    false
  elsif board[position.to_i] == "X" || board[position.to_i] == "O"
    true
  end
end

def valid_move?(board, position)
  position = position.to_i - 1
  if position.between?(0,8) && position_taken?(board, position) == false
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position) == true
    move(board, position, current_player(board))
    display_board(board)
  else
    puts "That is not a valid move."
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  elsif turn_count(board).odd?
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.any? do |combo|
    if combo.all? {|spot| position_taken?(board, spot)}
      if combo.all? {|spot| board[spot] == "X"}
        return combo
      elsif combo.all? {|spot| board[spot] == "O"}
        return combo
      end
    end
  end
end

def full?(board)
  board.all? {|spot| spot == "X" || spot == "O"}
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  elsif won?(board) == false && full?(board) == false
    return false
  elsif won?(board) == true
    false
  end
end

def over?(board)
  if won?(board) != false || draw?(board) == true || full?(board) == true
    return true
  end
end

def winner(board)
  if won?(board) == false
    return nil
  elsif won?(board).all? {|spot| board[spot] == "X"}
    return "X"
  elsif won?(board).all? {|spot| board[spot] == "O"}
    return "O"
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  elsif draw?(board) == true
    puts "Cats Game!"
  end
end
