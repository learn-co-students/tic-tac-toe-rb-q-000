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

def move(board, position, character = "X")
  board[position.to_i - 1] = character
end

def position_taken?(board, position)
  !(board[position].nil? || board[position] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1, 9) && !position_taken?(board, position.to_i - 1)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  board.inject(0) { |total, position| position == "X" || position == "O" ? total + 1 : total }
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X" ||
       board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
       return combination
     end
  end
  return false
end

def full?(board)
  board.all? { |position| position == "X" || position == "O" }
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  elsif !won?(board) && !full?(board)
    return false
  end
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  board[won?(board)[0]] if won?(board)
end

def play(board)
  turn(board) until over?(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end