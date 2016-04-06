WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, character="X")
  board[position.to_i - 1]=character
end

def position_taken?(board,position)
  (board[position] != " " && board[position] != "" && board[position] != nil)
end

def valid_move?(board,position)
  position = position.to_i - 1
  position.between?(0, 8) && !position_taken?(board, position)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position, character="X")
    display_board(board)
  else 
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
  counter
end

def current_player(board)
  if turn_count(board).odd? 
    "O"
  elsif turn_count(board).even?
    "X"
  end
end

def won?(board)
  empty = board.all? { |position| position == " "}
  if empty
    return false
  end
  board.all? { |position| position == "O"}
  board.all? { |position| position == "X"}

  WIN_COMBINATIONS.each do |win_combination|
    win_combination.each do |win_index|
    position_1 = board[win_index[0]]
    position_2 = board[win_index[1]]
    position_3 = board[win_index[2]]
  end
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end
  end
  return false
end


def full?(board)
  board.all? {|position| position == "X" || position == "O"}
end

def draw?(board)
  full?(board) == true && won?(board) == false
end

def over?(board)
  won?(board) == true || draw?(board) == true
end

def winner(board)
  winning_array = won?(board)
  if winning_array != false
    return board[winning_array.first]
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations".chomp 
  elsif draw?(board)
    puts "Cat's Game"
  end
end