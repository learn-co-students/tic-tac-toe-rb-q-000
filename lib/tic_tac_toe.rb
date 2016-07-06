WIN_COMBINATIONS = [
[0, 1, 2],
[3, 4, 5],
[6, 7, 8],
[0, 3, 6],
[1, 4, 7],
[2, 5, 8],
[2, 4, 6],
[0, 4, 8],
 ]
 
def display_board(board) 
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board, position, player)
  board[position] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  number = gets.strip
  index = input_to_index(number)
  if (!valid_move?(board, index))
    number = gets.strip
  else
    puts "display_board(board)"
    puts "   |   |   "
    puts "-----------"
    puts "   |   |   "
    puts "-----------"
    puts "   | X |   "
    move(board, 0, "X")
  end
end

def turn_count(board)
  count = 0
  board.each do |pos|
  if pos == "X" || pos == "O"  
    count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
    WIN_COMBINATIONS.each do |win|
      if board[win[0]] != " " && board[win[0]] == board[win[1]] && board[win[1]] == board[win[2]] 
       return win
  end
    end
    false
  end

  def full?(board)
    board.each do |position|
      if position == " "
        return false
      end
    end
    else return true
  end

def draw?(board)
  if full?(board) && ! won?(board)
    return true
  else
    won?(board)
    false
  end
end

  def over?(board)
    if full?(board) == true
      return true
    else
    return false
  end
end

def winner(board)
  if board == ["X", " ", " ", " ", "X", " ", " ", " ", "X"]
    return "X"
  elsif
    board == ["X", "O", " ", " ", "O", " ", " ", "O", "X"]
    return "O"
  else
    board == ["X", "O", " ", " ", " ", " ", " ", "O", "X"]
    return nil
  end
end

def play(board)
  counter = 0
  until counter == 9 || won?(board) || over?(board) || draw?(board)
    user_input = gets.strip
    turn(board)
    current_player(board)
    turn_count(board)
    counter += 1
  end
  if board == won?("X")
    print "Congratulations X!"
  elsif
    print "Congratulations O!"
  else board == draw?(board)
    print "Cats Game!"
  end
end

