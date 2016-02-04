WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8],  #Row Wins
  [0,3,6], [1,4,7], [2,5,8],  #Column Wins
  [0,4,8], [2,4,6]            #Diagonal Wins
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def move(board, position, char = "X")
  board[position.to_i - 1] = char
end


def position_taken?(board, position)
  if board[position] == "X" || board[position] == "O"
    return true
  else
    return false
  end
end


def valid_move?(board, position)
  position = position.to_i - 1
  if !(position_taken?(board, position)) && position.between?(0,8)
    return true
  else
    return false
  end
end


def turn(board)
  puts "Please enter a number 1-9 for the position you would like to move to"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position)
  else
    puts "Invalid move"
    turn(board)
  end
end

def turn_count(board)
  board.count("X") + board.count("O")
end


def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if board[win_combination[0]] != " " && ((board[win_combination[0]] == board[win_combination[1]]) && (board[win_combination[1]] == board[win_combination[2]]))
      return true
    end
  end
  return false
end

def full?(board)
  board.none? {|i| i == " "}
end

def draw?(board)
  if won?(board) || full?(board) == false
    return false
  else
    return true
  end
end


def over?(board)
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end


def winner(board)
  if won?(board) != false && board.count("X") > board.count("O")
    return "X"
  elsif board.count("O") > board.count("X")
    return "O"
  end
end


def play(board)
  until over?(board)
    puts "Select a space to place your move"
    position = gets.strip

    if valid_move?(board, position)
      char = current_player(board)
      move(board, position, char)
    end
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end