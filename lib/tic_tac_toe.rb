

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

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

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, position, character)
  board[position] = character
end

def position_taken?(board, index_number)
  if board[index_number] == " " || board[index_number] == "" || board[index_number] == nil
    false
  else board[index_number] == "X" || board[index_number] == "O"
  end
end

def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0, 8)
    true
  else
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, currentturn = current_player(board))
    display_board(board)
  else turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  winner = false
  WIN_COMBINATIONS.each do |wincombo|
    win_index_1 = wincombo[0]
    win_index_2 = wincombo[1]
    win_index_3 = wincombo[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      winner = wincombo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      winner = wincombo
    else
      false
    end
    break if winner
  end
  return winner
end

def full?(board)
  board.all? do |i|
    i == "X" || i == "O"
  end
end

def draw?(board)
   !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if wincombo = won?(board)
    board[wincombo.first]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{thewinner = winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
