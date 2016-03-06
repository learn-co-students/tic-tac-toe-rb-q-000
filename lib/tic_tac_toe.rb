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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def won?(board)
  WIN_COMBINATIONS.each do |i|
    subboard = board[i[0]..i[0]] + board[i[1]..i[1]] + board[i[2]..i[2]]
    return i if subboard.all? { |j| j == 'X' } or subboard.all? { |j| j == 'O' } 
  end
  false
end

def full?(board)
  board.all? { |i| i == 'X' or i == 'O' }
end

def draw?(board)
  full?(board) and !won?(board)
end

def over?(board)
  full?(board) or won?(board) or draw?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def turn_count(board)
  board.select { |i| i == 'X' or i == 'O'}.count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? 'X' : 'O'
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
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