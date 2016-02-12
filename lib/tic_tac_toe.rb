def greetings
  puts "Welcome to Tic Tac Toe!"
end

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

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def play(board) 
  turn(board) until over?(board)

  if winner(board)
    player = winner(board)
    puts "Congratulations #{player}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  turn(board) unless valid_move?(board, input)

  move(board, input, current_player(board))

  display_board(board)
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8],
  [0,3,6], [1,4,7], [2,5,8],
  [0,4,8], [2,4,6]
]

def won? (board)
  WIN_COMBINATIONS.each do |c|
    win_1, win_2, win_3 = c[0], c[1], c[2]
    positions = board[win_1], board[win_2], board[win_3]
  
    if (positions.all? { |p| p == "X" } || positions.all? { |p| p == "O" }) 
      return win_1, win_2, win_3
    end
  end
  return nil 
end

def full? (board)
  !board.any? { |e| e == " " } 
end

def draw? (board)
  !won?(board) && full?(board) 
end

def over? (board)
  won?(board) || full?(board) || draw?(board)
end

def winner (board)
  won_indices = won?(board)
  return board[won_indices[0]] if won_indices
  return nil 
end

def turn_count(board)
  test = /^[xo]$/i
  counter = 0
  board.each { |cell| counter += 1 if cell =~ test }
  counter 
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O" 
end