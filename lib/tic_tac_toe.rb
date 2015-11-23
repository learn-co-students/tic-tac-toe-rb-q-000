WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} |"
  puts "------------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} |"
  puts "------------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} |"
end

def move(board, position, player = "X")
  board[position.to_i-1] = player
end

def position_taken?(board, position)
  board[position.to_i] != " " && board[position.to_i] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |entry|
    if entry == "X" || entry == "O"
      count+=1
    end
  end
  return count
end

def current_player(board)
  turn_count(board)%2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    position_1 = board[combination[0]]
    position_2 = board[combination[1]]
    position_3 = board[combination[2]]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return combination
    else
      false
    end
  end
  false
end

def full?(board)
  board.detect{|entry| entry==" "}==nil ? true : false
end

def draw?(board)
  won?(board) == false && full?(board) == true ? true : false
end

def over?(board)
  won?(board) != false || draw?(board) == true || full?(board) == true ? true : false
end

def winner(board)
  array = won?(board)
  if array == false
    nil
  else
    board[array[0]] == "X" ? "X" : "O"
  end
end

def play(board)
  until over?(board) != false
    turn(board)
  end
  if won?(board)!= false
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cats Game!"
  end
end