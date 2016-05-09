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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player)
  board[location.to_i - 1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1, 9) && !position_taken?(board, position.to_i - 1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position != "" && position != " " && position != nil
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win = []
    combo.each do |index|
      win << board[index]
    end

    return combo if win == ["X", "X", "X"] || win == ["O", "O", "O"]
  end

  false
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board) ? true : false
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    win_combo = won?(board)
    winner = ""
    winner = board[win_combo[0]]
  end
end

def play(board)
  until over?(board) || won?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end