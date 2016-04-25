WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]]

def play(board)
  until over?(board)
    turn(board)
    won?(board)
    draw?(board)
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, character = "X")
    position = position.to_i
    board[position - 1] = character
    return board
end


def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position = position.to_i - 1
  if position_taken?(board, position) == true
    return false
  elsif position.between?(0, 8) == true
     return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.chomp
  character = current_player(board)

  if valid_move?(board, position) == true
    move(board, position, character)
    display_board(board)
  else
    puts "It looks like that isn't a valid move."
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
      return combo
    elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
      return combo
    elsif board.all?{|position| position == " "}
      return false
    end
  end

  if board.all?{|position| position == "X" || position == "O" }
    return false
  end
end

def full?(board)
  if board.any?{|position| position == " "}
    return false
  else
    return true
  end
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board) == true
    return true
  end
end

def over?(board)
  if draw?(board)
    puts "Cats Game!"
    return true
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    return "#{board[won?(board)[0]]}"
  end
end

def turn_count(board)
  counter = 0
  board.each do |square|
    if square != " "
      counter +=1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even? == true
    character = "X"
  else
    character = "O"
  end
 return character
end
