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
  board.each_slice(3).with_index(0) do |row, index|
    puts " #{row[0]} | #{row[1]} | #{row[2]} "
    puts "-----------" if index <= 2
  end
end

def move(board, pos, token="X")
  board[pos-1] = token
end

def position_taken?(board, pos)
  !(!board[pos] || !board[pos].strip[0])
end

def valid_move?(board, pos)
  pos.to_i.between?(1,9) && !position_taken?(board, pos.to_i-1)
end

def turn(board)
  puts "Where you wanna go?"
  input = gets.strip.to_i
  turn(board) if !valid_move?(board, input)
  move(board, input, current_player(board))
  display_board(board)
end

def turn_count(board)
  board.each.with_index.inject(0) { |count, (pos, index)| position_taken?(board, index) ? count+=1 : count}
end

def current_player(board)
  turn_count(board) % 2 == 0 ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.each do |comb|
   return comb if position_taken?(board, comb[0]) && comb.all? { |pos| board[pos] == board[comb[0]]}
  end
  nil
end

def full?(board)
  board.none? { |pos| pos != 'X' && pos != 'O'}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  (pos = won?(board)) ? board[pos[0]] : nil
end

def play(board)
  turn(board) until over?(board)
  puts ((pos = winner(board)) ? "Congratulations #{pos}!" : "Cats Game!")
end