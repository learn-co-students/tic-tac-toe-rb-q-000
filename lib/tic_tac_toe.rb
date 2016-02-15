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

def move(array, position, value='X')
  position = position.to_i
  array[position - 1] = value if array[position - 1] == ' '
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  valid_move?(board, input) ? move(board, input, current_player(board)) : turn(board)
  display_board(board)
end

def turn_count(board)
  board.count('X') + board.count('O')
end

def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end

def won?(board)
  empty = board.all? { |value| value == ' ' }
  win = WIN_COMBINATIONS.find do |group|
    board[group[0]] == board[group[1]] &&
    board[group[0]] == board[group[2]] &&
    position_taken?(board, group[0])
  end
  empty == true || win.nil? ? false : win
end

def full?(board)
  board.all? { |value| value == 'X' || value == 'O' }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end