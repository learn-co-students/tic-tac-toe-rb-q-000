# definition of WIN_COMBINATIONS constant
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

# code for #display_board

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  line = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts line
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts line
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code for #move

def move(board, position, char)
    board[position.to_i - 1] = char
end

# code for #position_taken?

def position_taken?(board, position)
  if (board[position] == "X") || (board[position] == "O")
    true
  else
    false
  end
end

# code for #valid_move?

def valid_move?(board, position)
  move = position.to_i - 1
   if (move.between?(0,8)) && (position_taken?(board, position.to_i - 1) == false)
     true
   else
     false
   end
end

# code for #turn?

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    if turn_count(board).even?
      move(board, position, char = "X")
    elsif turn_count(board).odd?
      move(board, position, char = "O")
    end
  else
    turn(board)
  end
  display_board(board)
end

# turn_count
def turn_count(board)
  count = 0
  board.each do |move|
    if move == "X" || move == "O"
      count += 1
    end
  end
  return count
end

# current_player
def current_player(board) turn_count(board).even? ? "X" : "O"
end


# won?
def won?(board)
  WIN_COMBINATIONS.any? do |win_combo|
    p1 = board[win_combo[0]]
    p2 = board[win_combo[1]]
    p3 = board[win_combo[2]]
    if p1 == "X" && p2 == "X" && p3 == "X"
      return win_combo
    elsif p1 == "O" && p2 == "O" && p3 == "O"
      return win_combo
    else
      false
    end
  end
end

# full?
def full?(board)
  board.all? do |location|
    location == "X" || location == "O"
  end
end

# draw?
def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  else
    false
  end
end

# over?
def over?(board)
  if draw?(board) == true || full?(board) == true || won?(board) != false
    true
  else
    false
  end
end

# winner
def winner(board)
  if won?(board) != false
    winner_combo = won?(board)
    return board[winner_combo[0]]
  else
    nil
  end
end

# play
def play(board)
  until over?(board) == true
   turn(board)
  end
  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
