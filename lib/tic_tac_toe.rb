require 'pry'

WIN_COMBINATIONS = [[0, 1, 2],
              [3, 4, 5],
              [6, 7, 8],
              [0, 3, 6],
              [1, 4, 7],
              [2, 5, 8],
              [0, 4, 8],
              [2, 4, 6]]

def display_board board
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index user_input
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn board
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  n = current_player(board)
  if valid_move?(board, index)
    move(board, index, n)
    display_board(board)
  else
    turn(board)
  end
end

def play board
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def turn_count board
  board.count { |pos| pos == 'X' || pos == 'O'}
end

def current_player board
  turn_count(board).even? ? 'X' : 'O'
end

def won? board
  WIN_COMBINATIONS.each do |indexes|
    x, y, z = indexes
    if board[x] != " " && (board[x] == board[y] && board[y] == board[z])
      return indexes
    end
  end
  false
end

def full? board
  board.all? { |index| index == "X" || index == "O"}
end

def draw? board
  !won?(board) && full?(board)
end

def over? board
  won?(board) || draw?(board)
end

def winner board
  x, y, z = won?(board)
  board[x] if over?(board)
end
# binding.pry
