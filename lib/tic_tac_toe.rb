def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if !valid_move?(board, index)
    turn(board)
  else
    display_board(move(board, index, current_player(board)))
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board, index, token)
  board[index] = token
  return board
end

def valid_move?(board, index)
  if index < 0 || index > 8
    return false
  else
    return !position_taken?(board, index)
  end
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  elsif board[index] == "X" || board[index] =="O"
    return true
  end
end






def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def turn_count(board)
  turn = 0
  board.each do |position|
    if position == "X" or position == "O"
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  turn = turn_count(board)
  return turn.even? ? "X" : "O"
end




def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  WIN_COMBINATIONS.detect { |combination| (board[combination[0]] == "X" || board[combination[0]] == "O") && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]] }
end

def full?(board)
  board.all? { |position| position == "X" || position == "O" }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

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
