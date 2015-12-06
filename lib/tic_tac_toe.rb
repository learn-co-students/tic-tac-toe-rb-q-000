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

def turn_count(board)
  turn = 0
  board.each do |spot|
    if spot == "X" || spot == "O"
      turn += 1
    end
  end
  return turn 
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else return "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  token = current_player(board)
  if valid_move?(board, input)
    move(board, input, token)
  else
    turn(board)
  end
  display_board(board)
end


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
  WIN_COMBINATIONS.detect do |win_combo|
    win_combo.all? { |index| board[index] == "X" } || win_combo.all? { |index| board[index] == "O" }  
  end
end

def full?(board)
  board.none? { |position| position == " " || position == nil }
end

def draw?(board)
  if full?(board) == true && won?(board) == nil
    return true
  elsif won?(board) != nil || full?(board) == false
    return false
  end
end

def over?(board)
  if draw?(board) == false && won?(board) == nil
    return false
  else return true
  end
end

def winner(board)
  if won?(board) == nil
    return nil
  else win_combo = won?(board) 
    board[win_combo[0]]
  end
end

def play(board)
  until over?(board) == true do
    turn(board)
  end
  if won?(board) != nil
      puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
      puts "Cats Game!"
  end
end








