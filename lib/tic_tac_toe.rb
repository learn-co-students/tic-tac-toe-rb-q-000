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
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def won?(board)
  if board.any? {|position| position == "X" || position == "O"
      WIN_COMBINATIONS.each do |win_combination|
        position_1 = board[win_combination[0]]
        position_2 = board[win_combination[1]]
        position_3 = board[win_combination[2]]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      end
      end}
    else
    return false
   end
end

def full?(board)
  if board.all? {|position| (position == "X" || position == "O")}
    true
  else
    false
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  end
end

def over?(board)
  if draw?(board) || full?(board) || won?(board)
    true
  end
end

def winner(board)
  if !won?(board)
    return nil
    elsif won?(board)
    x_count = 0
    o_count = 0
    board.each do |element|
      if element == "X"
        x_count += 1
      elsif element == "O"
        o_count += 1
      end
    end
  end
  if x_count > o_count
    return "X"
    elsif o_count > x_count
    return "O"
  end
end

def play(board)
  until over?(board)
      turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end