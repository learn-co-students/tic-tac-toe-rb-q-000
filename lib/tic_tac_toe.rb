WIN_COMBINATIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6],
                     [1,4,7], [2,5,8], [0,4,8], [6,4,2] ]

def display_board(board)
 puts " #{board[0]} | #{board[1]} | #{board[2]} "
 puts "-----------"
 puts " #{board[3]} | #{board[4]} | #{board[5]} "
 puts "-----------"
 puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char = 'X')
  board[position.to_i - 1] = char
end

def turn(board)
  invalid = true
  while invalid
    puts "Please enter 1-9:"
    input = gets.strip
    invalid = false if valid_move?(board, input)
  end
  move(board, input, current_player(board))
  display_board(board)
end

def turn_count(board)
 board.select { |square| square == "O" || square == "X" }.count
end

def current_player(board)
 turn_count(board) % 2 == 0 ? "X" : "O"
end

def valid_move?(board, position)
  position = position.to_i - 1
  position >= 0 && position <= board.length && !position_taken?(board, position)
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def won?(board)
  WIN_COMBINATIONS.find do |combo|
    position_taken?(board, combo[0]) &&
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]]
  end
end

def full?(board)
  board.each_with_index.all? { |square, i| position_taken?(board, i)}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  win_combo = won?(board)
  win_combo ? board[win_combo[0]] : nil
end

def play(board)
  turn(board) until over?(board)
  puts "Congratulations #{winner(board)}!" if winner(board)
  puts "Cats Game!" if draw?(board)
end