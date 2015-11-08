WIN_COMBINATIONS = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8],
  [0, 3, 6], [1, 4, 7], [2, 5, 8],
  [0, 4, 8], [2, 4, 6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn_count(board)
  board.select { |b| !b.strip.empty? }.count
end

def current_player(board)
  turn_count(board).odd? ? "O" : "X"
end

def move(board, position, player)
  board[position.to_i - 1] = player
end

def position_taken?(board, position)
  pos = board[position]
  if pos.nil? || pos.strip.empty?
    false
  elsif pos == "X" || pos == "O" 
    true
  end 
end

def valid_move?(board, position)
  pos = position.to_i - 1
  return false if pos == -1 || board[pos].nil? || position_taken?(board, pos)
  true
end

def turn(board)
  puts "Please enter 1-9:"
  turn = gets
  unless valid_move?(board, turn)
    turn = gets
  end 
  move(board, turn, "X")
  display_board(board)
end

# Define your play method below
def play(board)
  board.each do |b| 
    turn(board)
  end 
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    pos_0 = board[win_combo[0]]
    pos_1 = board[win_combo[1]]
    pos_2 = board[win_combo[2]]

    return win_combo if pos_0 == "X" && pos_1 == "X" && pos_2 == "X" 
    return win_combo if pos_0 == "O" && pos_1 == "O" && pos_2 == "O" 
  end 
  false
end

def full?(board)
  return true unless board.any? { |b| b.strip.empty? }
  false
end

def draw?(board)
  board.all? { |b| !b.strip.empty? } && !won?(board)
end

def over?(board)
  return false unless full?(board) || draw?(board)
  true
end

def winner(board)
  if combo = won?(board)
    board[combo.first]
  end
end
