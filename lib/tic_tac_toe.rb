WIN_COMBINATIONS = [
  [0,1,2], 
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def display_board (board = [" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "])
  puts (" #{board[0]} | #{board[1]} | #{board[2]} \n ----------- \n #{board[3]} | #{board[4]} | #{board[5]} \n ------------ \n #{board[6]} | #{board[7]} | #{board[8]} ")
end

def move(board, position, char = "X")
  board[position.to_i - 1] = char
end


def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  index = position.to_i - 1 
  if index < 0 || position_taken?(board, index) || index > board.count - 1 
    return false
  end
  return true
end


def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.chomp 
  if valid_move?(board, user_input) 
    move(board, user_input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  puts "Welcome to Tic Tac Toe!"
  display_board(board)
  puts "Where would you like to go?"
  counter = 0
  while counter < 9
    if over?(board)
      break
    end
    turn(board)
    counter += 1
  end
end


def won?(board)
    WIN_COMBINATIONS.each do |winning|
    if board[winning[0]].eql?("X") && board[winning[1]].eql?("X") && board[winning[2]].eql?("X")
      puts "Congratulations X!"
        return winning
    elsif board[winning[0]].eql?("O") && board[winning[1]].eql?("O") && board[winning[2]].eql?("O")
      puts "Congratulations O!"
        return winning
    end
  end
  return nil
end

def full?(board)
  return !board.include?(" ")
end

def draw?(board)
  if !full?(board) && !won?(board)
    return false
  elsif won?(board)
    return false
  elsif !full?(board)
    return false
  end
  return true
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    if draw?(board) 
      puts "Cats Game!"
    end
    return true
  end
  return false
end

def winner(board)
  winning_indexes = won?(board)
  if winning_indexes != nil && winning_indexes.count == 3
    return board[winning_indexes[0]]
  end
  return nil
end

def turn_count(board)
  turns = 0 
  board.each do |place|
    if place.eql?("X") || place.eql?("O") 
      turns += 1
    end
  end
  return turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else 
    return "O"
  end
end



