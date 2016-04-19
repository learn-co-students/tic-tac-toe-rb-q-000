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

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def move(board, pos, char = "X")
  board[pos.to_i - 1] = char
end

def position_taken?(board, position)
  !(board[position].nil? || board[position] == " ")
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-" * 11
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-" * 11
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if !valid_move?(board, input)
    turn(board)
  end
  move(board, input, current_player(board))
  display_board(board)
end

def turn_count(board)
  9 - board.count(" ")
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |arr|
    board[arr[0]] == board[arr[1]] &&
    board[arr[1]] == board[arr[2]] &&
    position_taken?(board, arr[0])
  end
end

def full?(board)
  board.count(" ") == 0
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  board[won?(board)[0]] if over?(board)
end