def display_board(board)
	puts " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2],
  ]

def move (board, input, char = "X")
  input = input.to_i
  input = input.pred
  board[input] = char
end

def valid_move?(board, position)
  position = position.to_i
  position = position.pred
  if !position_taken?(board, position) && position.between?(0, 8)
     true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    input = position
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |count|
    if count != " "
      counter += 1
    end
  end
  counter
end

def current_player(board)
  player =
    (turn_count(board).even? ? "X" : "O")
  player
end


def position_taken?(board, location)
  !(board[location].nil? || board[location] == " " || board[location] == "")
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_index|
    position_1 = board[win_index[0]]
    position_2 = board[win_index[1]]
    position_3 = board[win_index[2]]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      win_index
    elsif position_1 == "O" && position_2 =="O" && position_3 == "O"
      win_index
    else
      false
    end
  end
end

def full?(board)
  !(board.include?(" "))
end

def draw?(board)
  full?(board) && !(won?(board))
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if won?(board)
    win_token = won?(board)
    board[win_token[0]]
  end
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