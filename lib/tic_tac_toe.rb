def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player)
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
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

def play(board)
  while (over?(board)==false) do
    turn(board)
  end
  if (won?(board)!=false)
    puts "Congratulations #{winner(board)}!"
  elsif (draw?(board)==true)
  puts "Cats Game!"
  end

end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [2,5,8],
  [1,4,7]]

def won?(board)
  winning_board = []
  #check if X won
  WIN_COMBINATIONS.each do |combination|
    combination.each do |position|
      if (board[position] == "X")
        winning_board << position
      end
    end
    if (winning_board.size == 3)
      return winning_board
    else
      winning_board.clear
    end
  end

  #check if O won
  WIN_COMBINATIONS.each do |combination|
    combination.each do |position|
      if (board[position] == "O")
        winning_board << position
      end
    end
    if (winning_board.size == 3)
      return winning_board
    else
      winning_board.clear
    end
  end

  return false
end

def full?(board)
  board.each do |position|
    if (position==" " || position==nil)
      return false
    end
  end
    return true
end

def draw?(board)
  if (full?(board)==true && won?(board)==false)
    return true
  end
  return false
end

def over?(board)
  if (draw?(board)==true || won?(board)!=false)
    return true
  end
  return false
end

def winner(board)
  if (won?(board)==false)
    return nil
  else
    winning_array = won?(board)
    return board[winning_array[0]]
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if (position=="X" || position=="O")
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  count = turn_count(board)
  if (count%2==0)
    return "X"
  else return "O"
  end
end