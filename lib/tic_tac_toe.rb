WIN_COMBINATIONS = [
  [0,1,2], # Top Row
  [3,4,5], # Middle Row
  [6,7,8], # Bottom Row
  [0,4,8], # Top-Left, Middle, Bottom-right
  [2,4,6], # Top-Right, Middle, Bottom-left
  [0,3,6], # Left Row
  [1,4,7], # Middle Row
  [2,5,8] # Right Row
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, char)
  board[location.to_i - 1] = char
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  elsif board[position] == "X" || board[position] == "O"
    true
  end
end

def valid_move?(board, move)
  interger = move.to_i - 1
  if position_taken?(board, interger) == true
    false
  elsif position_taken?(board, interger) == false && interger.between?(0,8) == true
    true
  end
end

def turn(board)
  char = current_player(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, char)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  round = 0
  board.each do |count|
    if count == "X" || count == "O"
      round += 1
    end
  end
  round
end

def current_player(board)
    turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  empty_board = board.all? do |empty|
    empty == " "
  end

  if empty_board == true
    return false
  else WIN_COMBINATIONS.each do |wins|
        if board[wins[0]] == "X" && board[wins[1]] == "X" && board[wins[2]] == "X"
          return wins
        elsif board[wins[0]] == "O" && board[wins[1]] == "O" && board[wins[2]] == "O"
          return wins
        end
      end
      return false
  end
end

def full?(board)
  full_board = board.all? do |full|
    full == "X" || full == "O"
  end
end

def draw?(board)
  return true if full?(board) && won?(board) == false
  return false if won?(board) == false && full?(board) == false
end

def over?(board)
  if draw?(board) || full?(board) || won?(board)
    true
  end
end

def winner(board)
  if over?(board)
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
      turn(board)
  end

  if draw?(board)
    puts "Cats Game!"
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end
