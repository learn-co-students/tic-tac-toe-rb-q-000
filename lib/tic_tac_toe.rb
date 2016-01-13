#display_board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#move
def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

#position_taken
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

#valid_move
def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

#turn
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

#play
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end
end

#turn_count
def turn_count(board)
  counter = 0
    board.each do |move|
      if (move == "X" || move == "O")
        counter += 1
      end
    end
return counter
end

#current_player
def current_player(board)
  counter = 0
    board.each do |move|
      if (move == "X" || move == "O")
        counter += 1
      end
    end

  if (counter % 2 == 0)
    return "X"
  elsif (counter % 2 != 0)
    return "O"
  end
end


#WIN_COMBINATIONS
  WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

#won
def won?(board)
  result = false
  WIN_COMBINATIONS.each do |combinations|
    win_index_1 = combinations[0]
    win_index_2 = combinations[1]
    win_index_3 = combinations[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if result == false
      if ((position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O"))
      result = combinations
      else
        result = false
      end
    end
  end
  result
end

#full
def full?(board)
  board.all?{|elements| !(elements == " " || elements == nil)}
end

#draw
def draw?(board)
  return true if (won?(board) == false && full?(board) == true)
  return false if (won?(board) != false || full?(board) == false )
end

#over
def over?(board)
  won?(board) || full?(board) || draw?(board)
end

#over
def winner(board)
  winning_location = won?(board)
  if winning_location
    board[winning_location[0]]
  else return nil
  end
end