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

def move(board, location, character = current_player(board))
  board[location.to_i - 1] = character
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
  if valid_move?(board, input)
    move(board, input)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  turn = 0
  board.each_index {|i| turn += 1 if position_taken?(board, i)}
  turn
end

def current_player(board)
  return 'X' if turn_count(board) % 2 == 0
  return 'O' if turn_count(board) % 2 != 0
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination| 

    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_combination[0])
      return win_combination
    else
      false
    end

  end
  false
end

def full?(board)
  board.all? {|x| x == 'X' || x == 'O'}
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  if WIN_COMBINATIONS.any? {|x| board[x[0]] == 'X' && board[x[1]] == 'X' && board[x[2]] == 'X'}
    'X'
  elsif WIN_COMBINATIONS.any? {|x| board[x[0]] == 'O' && board[x[1]] == 'O' && board[x[2]] == 'O'}
    'O'
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end