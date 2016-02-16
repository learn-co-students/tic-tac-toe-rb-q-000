WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char='X')
  board[position.to_i-1] = char
end

def position_taken?(board, position)
  !(board[position].nil? || board[position] == " ")
end

def valid_move?(board, position)
  (position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1))
end

def turn(board)
  puts "Please enter 1-9:"
  player_move = gets.strip

  if !valid_move?(board, player_move)
    puts "Please enter 1-9:"
    player_move = gets.strip
  else
    move(board, player_move, current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |space|
    if space == "X" || space == "O"
      turns += 1
    end
  end

  turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    combo.all? { |pos| position_taken?(board, pos) } && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
  end
end

def full?(board)
  board.all? { |pos| !(pos.nil? || pos == " ") }
end

def draw?(board)
  !won?(board) && full?(board) 
end

def over?(board)
  won?(board) || draw?(board)
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