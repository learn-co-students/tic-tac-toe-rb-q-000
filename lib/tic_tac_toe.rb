#Helper methods defined in other labs

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

#the only one not mine
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, player = "X")
  board[position.to_i-1] = player
end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def position_taken?(board, position)
  
  if board[position] == " " || board[position] == "" || 
    board[position] == nil
    false
  elsif board[position] == "X" || board[position] == "O"
    true 
  end
end

# def position_taken?(board, location)
#   !(board[location].nil? || board[location] == " ")
# end

def valid_move?(board, position)
  position = position.to_i-1
  if position_taken?(board, position) == false
    if position.between?(0, 8) 
      true
    else
      false  
    end
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
    if !valid_move?(board, position) 
      turn(board)
    else
      move(board, position, current_player(board))
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
  counter
end


def current_player(board)
  if turn_count(board).even?
    player = "X"
  else
    player = "O"
  end
end

def won?(board)
  win = WIN_COMBINATIONS.find do |win_combination|
    board[win_combination[0]] == "X" && 
    board[win_combination[1]] == "X" && 
    board[win_combination[2]] == "X" ||
    board[win_combination[0]] == "O" &&
    board[win_combination[1]] == "O" &&
    board[win_combination[2]] == "O"
  end
  if win 
    win
  else
    false
  end
end


def full?(board)
  board.none? {|position| position == " "}
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  elsif won?(board) == false && full?(board) == false
    false
  elsif won?(board) == true
    false
  end
end

def over?(board)
  #accepts board and is true if won, full, or draw is true
  if won?(board) == true || 
    full?(board) == true || 
    draw?(board) == true
    true
  else
    false
  end
end

def winner(board)
  if won?(board) != false
    WIN_COMBINATIONS.each do |win_combination|
      if board[win_combination[0]] == "X" && 
        board[win_combination[1]] == "X" &&
        board[win_combination[2]] == "X" 
        return "X"
      elsif board[win_combination[0]] == "O" && 
        board[win_combination[1]] == "O" &&
        board[win_combination[2]] == "O" 
        return "O"
      end
    end
  else
    nil
  end
end

def play(board)
  until over?(board) == true || won?(board) != false 
    turn(board)
  end
  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end

#until the game is over or if someone has won 
  #turn
