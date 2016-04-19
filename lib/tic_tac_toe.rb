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

def move(board, pos, char = "X")
  board[pos.to_i - 1] = char
  board
end

def valid_move?(board, position)
  pos = position.to_i - 1
  !position_taken?(board,pos) && !board[pos].nil? if pos >= 0
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

def position_taken?(board, position)
  if board[position] == "X" || board[position] == "O"
    true
  else
    false
  end
end

def valid_move?(board, position)
  pos = position.to_i - 1
  !position_taken?(board, pos) && !board[pos].nil? && pos >= 0
end

def move(board, pos, sign = "X")
  board[pos - 1] = sign
  board
end

def turn(board)
  loop do
    puts 'Please enter 1-9:'
    position = gets.strip
    if valid_move?(board, position)
      move(board, position.to_i, current_player(board))
      display_board(board)
      break
    else
      puts "invalid"
    end
  end
end

def turn_count(board)
  9 - board.count(" ")
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

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