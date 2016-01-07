WIN_COMBINATIONS = [[0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #left column
  [1, 4, 7], #mid column
  [2, 5, 8], #right column
  [0, 4, 8], #diagonal down
  [6, 4, 2]] #diagonal up


def play(board)
  until over?(board)
    turn(board)
    turn_count(board)
    current_player(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end


def display_board(board)
  puts " #{board[0]} ""|"" #{board[1]} ""|"" #{board[2]} "
  puts "-----------"
  puts " #{board[3]} ""|"" #{board[4]} ""|"" #{board[5]} "
  puts "-----------"
  puts " #{board[6]} ""|"" #{board[7]} ""|"" #{board[8]} "
end


def move(array, position, value="X")
  array[position.to_i - 1] = value
end


def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end


def valid_move?(board, position)
  position = position.to_i
  if !(position.between?(1, 9)) || position_taken?(board, position - 1)
    return false
  else
    return true
  end
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  while !(valid_move?(board, input))
    puts "That's not valid input.  Please enter 1-9."
    input = gets.strip
  end
  move(board, input,(current_player(board)))
  display_board(board)
end


def turn_count(array)
  count = 0
  array.each do |pos|
    if pos == "X" || pos == "O" then
      count += 1
    end
   end
 return count
end


def current_player(board)
  if turn_count(board) % 2 == 0
    current_player = "X"
  else
    current_player = "O"
  end
  return current_player
end

def won?(board)
    count = 0
    WIN_COMBINATIONS.each do |combi|
    if (board[combi[0]] == "X" && board[combi[1]] == "X" && board[combi[2]] == "X" ||
    board[combi[0]] == "O" && board[combi[1]] == "O" && board[combi[2]] == "O")
      #puts "#{combi} is a winning combination"
      return combi
    else
      count += 1
      if count == 8
        return false
      end
    end
  end
end


def full?(board)
  board.each do |pos|
    if pos != " "
      next
      return true
    else
      return false
    end
  end
end


def draw?(board)
  if !(won?(board)) && full?(board)
    return true
  else
    return false
  end
end


def over?(board)
  if (full?(board)) || (draw?(board)) || (won?(board))
    return true
  else
    return false
  end
end


def winner(board)
  if won?(board) == false
    return nil
  elsif board[won?(board)[0]] == "X"
    return "X"
  elsif board[won?(board)[0]] == "O"
    return "O"
  end
end











