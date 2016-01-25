WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
  ]

def display_board(board = [" "," "," "," "," "," "," "," "," "])
  row_seperator = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts row_seperator
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts row_seperator
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, character = "X")
  board[position.to_i - 1] = character
end

def position_taken?(board, position)
  !(board[position] == " " || board[position] == "" || board[position] == nil)
end

def valid_move?(board, position)
  int_position = position.to_i
  int_position.between?(1, 9) && position_taken?(board, int_position - 1) == false
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input)
    display_board(board)
  else
    puts "You entered an invalid move."
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |character|
    if character == "X" || character == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end