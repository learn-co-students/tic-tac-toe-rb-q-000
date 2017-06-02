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
  row = "-----------"
  puts " #{board[0]} " + '|' + " #{board[1]} " + '|' + " #{board[2]} "
  puts row
  puts " #{board[3]} " + '|' + " #{board[4]} " + '|' + " #{board[5]} "
  puts row
  puts " #{board[6]} " + '|' + " #{board[7]} " + '|' + " #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  !(position_taken?(board,index) || index < 0 || index > 9)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(board, index)
    turn(board)
    move(board, index, current_player(board))
    display_board(board)
  else
    move(board, index, current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

#constant
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

def won?(board)
  result = false
  WIN_COMBINATIONS.each do |win_combination|
    if !result
      if win_combination.all?{|i| board[i] == "X"} || win_combination.all?{|i| board[i] == "O"}
        result = win_combination
      end
    end
  end
  return result
end

def full?(board)
  board.all? {|i| (i == "X" || i == "O")}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  winner_token = won?(board)
  if winner_token
    board[winner_token[0]]
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
    end
    if draw?(board)
      puts "Cats Game!"
    end
end
