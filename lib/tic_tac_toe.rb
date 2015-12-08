WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char = "X")
  board[position - 1] = char
end

def position_taken?(board, position)
  value = board[position]
  if value == " " || value == "" || value == nil 
    false  
  elsif value == "X" || value == "O"
    true
  end
end

def valid_move?(board, position)
  position = position.to_i
  position.between?(1,9) && !position_taken?(board, position - 1)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position.to_i, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  turns = board.select do |space|
    space == "X" || space =="O"
  end
  turns.size
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  result = WIN_COMBINATIONS.select do |combo|
    ["X", "O"].any? do |player|
      combo.all? do |space|
        board[space] == player
      end
    end
  end
  result != [] ? result[0] : false
end

def full?(board)
  board.all? do |board_space|
    board_space == "X" || board_space == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  winning_combo = won?(board)
  winning_combo ? board[winning_combo[0]] : nil
end

def play(board)
  until over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!" 
  end
end

