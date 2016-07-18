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

def input_to_index(input)
  input.to_i-1
end

def move(board, position, char)
  board[position] = char
end

def position_taken?(board, index)
  position = board[index]
  if [' ', '', nil].include?(position)
    return false
  else
    return true
  end
end

# def valid_move?(board, index)
#   if !index.between?(0, board.length)
#     return false
#   else
#     return !position_taken?(board, index)
#   end
# end

def valid_move?(board, index)
  if index.between?(0, board.length) && !position_taken?(board, index)
    return true
  else
    return false
  end
end

def turn(board)
  puts("Please enter 1-9:")
  index = input_to_index(gets.chomp)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.length - board.count(' ')
end

def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.each do |row|
    first = board[row[0]]
    win = row.all? do |i|
      position_taken?(board, i) && board[i] == first
    end
    if win
      return row
    end
  end
  nil
end

def full?(board)
  board.all? do |i|
    ['X', 'O'].include?(i)
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  win = won?(board)
  if !win
    return nil
  end
  board[win[0]]
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











