WIN_COMBINATIONS = [
  [0,1,2], # T row
  [3,4,5],  # M row
  [6,7,8],  # B row
  [0,3,6],  # L col
  [1,4,7],  # M col
  [2,5,8],  # R col
  [0,4,8],  # L dia
  [2,4,6]  # R dia
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    if winner(board) == "X"
      puts "Congratulations X!"
    elsif winner(board) == "O"
      puts "Congratulations O!"
    end
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9 to make your move:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, char=current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |turns|
    if turns == "X" || turns == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  elsif turn_count(board) % 2 == 1
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_1 = combo[0]
    win_2 = combo[1]
    win_3 = combo[2]

    position_1 = board[win_1]
    position_2 = board[win_2]
    position_3 = board[win_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return combo # return the win_combination indexes that won.
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return combo
    end
  end
    return false
end

def full?(board)
  board.all? { |position| position == "X" || position == "O" }
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    true
  elsif won?(board) == true
    false
  elsif full?(board) == false
    false
  end
end

def over?(board)
  if draw?(board) == true
    true
  elsif won?(board)
    true
  elsif full?(board) == false
    false
  end
end

def winner(board)
  if won?(board)
    winning_array = won?(board)
    if winning_array.any? { |i| board[i] == "X" }
      return "X"
    elsif winning_array.any? { |i| board[i] == "O" }
      return "O"
    end
  end
end

#0 | 1 | 2
#---------
#3 | 4 | 5
#---------
#6 | 7 | 8
