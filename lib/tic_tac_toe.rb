def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end



def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
 
  if valid_move?(board, index)
    cp = current_player(board)
    move(board, index, cp)
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below


def play(board)

  index = 9

  while index > 0
    
    turn(board)

    index -= 1
  end
 
end

def turn_count(board)

  counter = 0

  board.each do |x|

    if x == "X" || x == "O"
      counter +=1
    end

  end

  counter

end


def current_player(board)

  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end

end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant

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

def won?(board)

  return false if board.include?("X") == false && board.include?("O") == false

  WIN_COMBINATIONS.each do |x|

    if board[x[0]] == "X" && board[x[1]] == "X" && board[x[2]] == "X"
      return x
    elsif board[x[0]] == "O" && board[x[1]] == "O" && board[x[2]] == "O"
      return x
    end

  end

  return false

end


def full?(board)
  
  board.each do |x|
    if x == " "
      return false
    end
  end

  return true

end

def draw?(board)

  if !won?(board) && full?(board)
    return true
  end

  return false

end

def over?(board)

  if draw?(board)
    return true
  elsif won?(board)
    return true
  elsif full?(board)
    return true
  else
    return false
  end

end

def winner(board)

  if !won?(board)
    return nil
  end


  winning_array = won?(board)

  return board[winning_array[0]]

end

def play(board)
  while over?(board) == false
    turn(board)
  end

  puts "Congratulations #{winner(board)}!" if draw?(board) == false
  puts "Cats Game!" if draw?(board) == true


end