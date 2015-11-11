WIN_COMBINATIONS = [
  [0, 1, 2],
  [6, 7, 8],
  [2, 5, 8],
  [0, 3, 6],
  [1, 4, 7],
  [3, 4, 5],
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

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip

  # TODO: implement recursion
  until valid_move?(board, position)
    puts "Please enter 1-9:"
    position = gets.strip
  end

  move(board, position, current_player(board))
  display_board(board)   
end

def turn_count(board)
  count = 0
  board.each { |elem| count +=1 if elem == "X" || elem == "O" }
  count
end

def current_player(board)    
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.find do |win_combo|
    x_wins = win_combo.all? { |pos| board[pos] == "X" }
    o_wins = win_combo.all? { |pos| board[pos] == "O" }
    win_combo if x_wins || o_wins
  end
end

def full?(board)
 board.all? { |pos| pos != " " } 
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  board.all? { |pos| pos == "X" || pos == "O" }
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
  while !won?(board) && !over?(board) && !draw?(board)
      turn(board)
      break if draw?(board) || over?(board) || won?(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end 

  if draw?(board)
    puts "Cats Game!" 
  end

  if over?(board) || won?(board)
    false
  end
end