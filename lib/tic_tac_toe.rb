WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board,input,char = "X")
  input = input.to_i
  board[(input-1)] = char
end

def position_taken? (board,position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    return false
  else
    return true
  end
end

def valid_move?(board,position)
  position = (position.to_i) - 1
  if position_taken?(board,position)  == false && position.between?(0,8)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.chomp
  until valid_move?(board,position) == true
    puts "Please enter 1-9:"
    position = gets.chomp
  end
  move(board,position,char = "X")
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |board|
    if board == "X" || board == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board)%2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  indexes = Array.new
  if WIN_COMBINATIONS.any? do |combination|
    indexes = combination
    board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X" || board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
  end
  return indexes
else
  return false
end
end

def full?(board)
  board.all? {|position| position == "X" || position == "O"}
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  elsif
    full?(board) == false && won?(board) == false
    return false
  else
    false
  end
end

def over?(board)
  if won?(board) == true || draw?(board) == true || full?(board) == true
    return true
   else
    return false
   end
end

def winner(board)
  if won?(board) == false
      return nil
    end
  won?(board).each do |position|
    if board[position] == "X"
      return "X"
    else board[position] == "O"
      return "O"
    end
  end
end

def play(board)
  until over?(board) == true
     turn(board)
